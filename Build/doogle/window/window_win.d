module doogle.window.window_win;
import doogle.window.window;
import doogle.window.context;
import doogle.window.types;
import doogle.window.component;
import doogle.events.event;
import doogle.events.types;
import doogle.platform;

import core.sync.rwmutex;

version(Windows) {
	shared(Window)[size_t] windows;
	ReadWriteMutex rwmWindows;

	static this() {
		rwmWindows = new ReadWriteMutex(ReadWriteMutex.Policy.PREFER_READERS);
	}

	shared class Window_Win : Window_Def {
		protected {
			platform.windows.HWND _window;
			platform.windows.MSG _msg;
			platform.windows.WNDCLASS _wndclass;
			size_t _windowId;
			uint _style;
		}

		this(uint width = 800, uint height = 600, string title = "Window", WindowStyle style = WindowStyle.Close) {
			synchronized(rwmWindows) {
				static size_t windowCount;
				_windowId = windowCount;
				windowCount++;
				windows[_windowId] = this;
				
				string appName = "DOOGLE_WINDOW";
				_wndclass.style         = platform.windows.CS_HREDRAW | platform.windows.CS_VREDRAW;
				_wndclass.lpfnWndProc   = &windowEventHandler;
				_wndclass.cbClsExtra    = 0;
				_wndclass.cbWndExtra    = 0;
				_wndclass.hInstance     = cast(shared)platform.windows.GetModuleHandleA(null);//hInstance;
				_wndclass.hIcon         = cast(shared)platform.windows.LoadIconA(null, cast(char*)platform.windows.IDI_APPLICATION);
				_wndclass.hCursor       = cast(shared)platform.windows.LoadCursorA(null, cast(char*)platform.windows.IDC_ARROW);
				_wndclass.hbrBackground = cast(shared(platform.windows.HBRUSH))platform.windows.GetStockObject(platform.windows.WHITE_BRUSH);
				_wndclass.lpszMenuName  = null;
				_wndclass.lpszClassName = appName.ptr;

				if(!platform.windows.RegisterClass(cast(platform.windows.WNDCLASS*)&_wndclass)) {
					platform.windows.MessageBoxA(null, "This program requires Windows NT!", appName.ptr, platform.windows.MB_ICONERROR);
					return;
				}

				// Configure window style
				ulong windowStyle;
				if (style & WindowStyle.FullScreen) 
					windowStyle = platform.windows.WS_OVERLAPPEDWINDOW | platform.windows.WS_CLIPSIBLINGS | platform.windows.WS_CLIPCHILDREN;
				else
					windowStyle = platform.windows.WS_CAPTION | platform.windows.WS_MINIMIZEBOX | platform.windows.WS_VISIBLE;
				if (style & WindowStyle.Close) windowStyle |= platform.windows.WS_SYSMENU;
				if (style & WindowStyle.Resize) windowStyle |= platform.windows.WS_SYSMENU | platform.windows.WS_THICKFRAME | platform.windows.WS_MAXIMIZEBOX;

				_window = cast(shared)platform.windows.CreateWindowA(appName.ptr,      // window class name
				                     title.ptr,  // window caption
				                     cast(uint)windowStyle,  // window style
	                                 platform.windows.CW_USEDEFAULT,        // initial x position
	                         		 platform.windows.CW_USEDEFAULT,        // initial y position
				                     width,        // initial x size
				                     height,        // initial y size
				                     null,                 // parent window handle
				                     null,                 // window menu handle
	                                 platform.windows.GetModuleHandleA(null),            // program instance handle
				                     cast(void*)_windowId);                // creation parameters

				if (_window is null) {
					platform.windows.MessageBoxA(null, "Window creation failed!", appName.ptr, platform.windows.MB_ICONERROR);
					return;
				}
			
				if (style & WindowStyle.FullScreen) {
					//isFullScreen(true);
					_width = width;
					_height = height;
					updateStyle(WindowStyle.FullScreen);
				} else {
					// Calculate window size for requested client size
					platform.windows.RECT rect = {0, 0, width, height};
					platform.windows.AdjustWindowRect(&rect, cast(uint)windowStyle, cast(int)false);
					width = cast(uint)(rect.right - rect.left);
					height = cast(uint)(rect.bottom - rect.top);
					
					// Center window on screen
					platform.windows.GetClientRect(platform.windows.GetDesktopWindow(), &rect);
					x = cast(uint)(rect.right - rect.left - width) / 2;
					y = cast(uint)(rect.bottom - rect.top - height) / 2;
					
					//_isFullScreen = false;
				}

				platform.windows.RECT rect;

				platform.windows.GetWindowRect(cast(void*)_window, &rect);
				this.x = cast(uint)rect.left;
				this.y = cast(uint)rect.top;

				this.width = cast(uint)(rect.right - rect.left);
				this.height = cast(uint)(rect.bottom - rect.top);

				_isOpen = true;
				_mouseX = 0;
				_mouseY = 0;
				_context = null;
				_windowStyle = style;
			}
		}

		~this() {
			synchronized {
				if (!_isOpen) return;
				platform.windows.DestroyWindow(cast(void*)_window);
				platform.windows.UnregisterClass("DOOGLE_WINDOW", platform.windows.GetModuleHandle(null));
			}
			synchronized(rwmWindows) {
				windows[_windowId] = null;
			}
		}

		public {
			@property {
				shared(platform.windows.HWND) hwnd() { synchronized return _window; }

				void hwnd(shared(platform.windows.HWND) hwnd) { synchronized _window = hwnd; }

				size_t id() { synchronized return _windowId; }

				/**
				 * Component
				 */
				override void resize() {
					synchronized {
						if (!_isOpen) return;
						platform.windows.RECT rect = {0, 0, _width, _height};
						platform.windows.AdjustWindowRect(&rect, _style, false);
						platform.windows.SetWindowPos(cast(void*)_window, null, 0, 0, cast(uint)(rect.right - rect.left), cast(uint)(rect.bottom - rect.top), platform.windows.SWP_NOMOVE | platform.windows.SWP_NOZORDER);
					}
				}

				override void relocate() {
					synchronized {
						if (!_isOpen) return;
						platform.windows.SetWindowPos(cast(platform.windows.HWND)_window, null, cast(shared)_x, cast(shared)_y, 0, 0, platform.windows.SWP_NOSIZE | platform.windows.SWP_NOZORDER);
					}
				}

				/**
				 * Window_Def
				 */
				override void updateStyle(WindowStyle style) {
					synchronized {
						if (style & WindowStyle.FullScreen) {
							// make full screen
							platform.windows.DEVMODE dm;
							dm.dmSize = dm.sizeof;
							dm.dmPelsWidth = _width;
							dm.dmPelsHeight = _height;
							dm.dmBitsPerPel = 32;
							dm.dmFields = platform.windows.DM_PELSWIDTH | platform.windows.DM_PELSHEIGHT | platform.windows.DM_BITSPERPEL;

							ulong windowStyle = platform.windows.WS_POPUP | platform.windows.WS_CLIPCHILDREN | platform.windows.WS_CLIPSIBLINGS;

							platform.windows.ChangeDisplaySettings(&dm, platform.windows.CDS_FULLSCREEN);
							platform.windows.SetWindowLong(cast(void*)_window, platform.windows.GWL_STYLE, cast(uint)windowStyle);
							platform.windows.SetWindowLong(cast(void*)_window, platform.windows.GWL_EXSTYLE, platform.windows.WS_EX_APPWINDOW);
							
							platform.windows.SetWindowPos(cast(void*)_window, platform.windows.HWND_TOP, 0, 0, _width, _height, platform.windows.SWP_FRAMECHANGED);
							visible = true;

							_style = cast(uint)windowStyle;
							_windowStyle = style;
						} else {
							ulong windowStyle = platform.windows.WS_CAPTION | platform.windows.WS_MINIMIZEBOX | platform.windows.WS_VISIBLE;
							if (style & WindowStyle.Close) windowStyle |= platform.windows.WS_SYSMENU;
							if (style & WindowStyle.Resize) windowStyle |= platform.windows.WS_SYSMENU | platform.windows.WS_THICKFRAME | platform.windows.WS_MAXIMIZEBOX;

							platform.windows.DEVMODE dm;
							dm.dmSize = dm.sizeof;
							dm.dmPelsWidth = width;
							dm.dmPelsHeight = height;
							dm.dmBitsPerPel = 32;
							dm.dmFields = platform.windows.DM_PELSWIDTH | platform.windows.DM_PELSHEIGHT | platform.windows.DM_BITSPERPEL;
							
							platform.windows.SetWindowLong(cast(void*)_window, platform.windows.GWL_STYLE, cast(uint)windowStyle);
							platform.windows.SetWindowPos(cast(void*)_window, platform.windows.HWND_TOP, 0, 0, _width, _height, platform.windows.SWP_FRAMECHANGED);

							_style = cast(uint)windowStyle;
							_windowStyle = style;
						}
					}
				}
			}

			override shared(Context) getContext(ubyte color = 32, ubyte depth = 24, ubyte stencil = 8, ubyte antialias = 1) {
				synchronized {
					if (_context !is null) {
						return _context;
					} else {
						_context = new shared Context(color, depth, stencil, antialias, cast(shared)platform.windows.GetDC(cast(void*)_window));
						DerelictGL3.reload();
						return _context;
					}
				}
			}

			override void redraw() {
				synchronized {
					if (!_context) return;
					_context.activate();
					platform.windows.UpdateWindow(cast(void*)_window);
					platform.windows.SwapBuffers(platform.windows.GetDC(cast(void*)_window));
				}
			}

			override void visible(bool mode) {
				synchronized {
					platform.windows.ShowWindow(cast(void*)_window, mode ? platform.windows.SW_SHOW : platform.windows.SW_HIDE);
					platform.windows.UpdateWindow(cast(void*)_window);
					_isOpen = mode;
				}
			}

			override void close() {
				synchronized {
					if(_isOpen) {
						platform.windows.CloseWindow(cast(void*)_window);
						_isOpen = false;
					}
				}
			}

			override bool event() {
				synchronized {
					platform.windows.MSG msg;
					size_t length = _events.length;
					while (platform.windows.PeekMessage(&msg, null, 0, 0, platform.windows.PM_REMOVE)) {
						platform.windows.TranslateMessage(&msg);
						platform.windows.DispatchMessage(&msg);
					}
					return length > _events.length;
				}
			}
		}

		protected {
			platform.windows.LRESULT windowEvent(uint msg, platform.windows.WPARAM wParam, platform.windows.LPARAM lParam) {
				synchronized {
					Event ev;
					ev.type = EventTypes.Unknown;
					
					// Translate message to Event
					switch (msg)
					{
						case platform.windows.WM_CLOSE:
							close();
							ev.type = EventTypes.Close;
							break;
							
						case platform.windows.WM_SIZE:
							width = platform.windows.LOWORD(lParam);
							height = platform.windows.HIWORD(lParam);
							
							if (_events.length == 0) {
								ev.type = EventTypes.Resize;
								ev.window.width = width;
								ev.window.height = height;
							} else if (_events[$-1].type == EventTypes.Resize) {
								_events[$-1].window.width = width;
								_events[$-1].window.height = height;
							}
							break;
							
						case platform.windows.WM_MOVE:
							platform.windows.RECT rect;
							platform.windows.GetWindowRect(cast(void*)_window, &rect);
							x = cast(uint)rect.left;
							y = cast(uint)rect.top;
							
							if (_events.length == 0) {
								ev.type = EventTypes.Move;
								ev.window.x = x;
								ev.window.y = y;
							} else if (_events[$-1].type == EventTypes.Move) {
								_events[$-1].window.x = x;
								_events[$-1].window.y = y;
							}
							break;
							
						case platform.windows.WM_ACTIVATE:
							if (wParam == platform.windows.WA_INACTIVE) {
								ev.type = EventTypes.Blur;
								_hasFocus = false;
								return 0;
							} else {
								ev.type = EventTypes.Focus;
								_hasFocus = true;
								break;
							}
							
						case platform.windows.WM_KEYDOWN:
						case platform.windows.WM_SYSKEYDOWN:
							ev.type = EventTypes.KeyDown;
							ev.key.code = translateKey(cast(uint)wParam);
							ev.key.alt = platform.windows.HIWORD(platform.windows.GetAsyncKeyState(platform.windows.VK_MENU)) != 0;
							ev.key.control = platform.windows.HIWORD(platform.windows.GetAsyncKeyState(platform.windows.VK_CONTROL)) != 0;
							ev.key.shift = platform.windows.HIWORD(platform.windows.GetAsyncKeyState(platform.windows.VK_SHIFT)) != 0;
							
							_keys[ev.key.code] = true;
							break;
							
						case platform.windows.WM_KEYUP:
						case platform.windows.WM_SYSKEYUP:
							ev.type = EventTypes.KeyUp;
							ev.key.code = translateKey(cast(uint)wParam);
							ev.key.alt = platform.windows.HIWORD(platform.windows.GetAsyncKeyState(platform.windows.VK_MENU)) != 0;
							ev.key.control = platform.windows.HIWORD(platform.windows.GetAsyncKeyState(platform.windows.VK_CONTROL)) != 0;
							ev.key.shift = platform.windows.HIWORD(platform.windows.GetAsyncKeyState(platform.windows.VK_SHIFT)) != 0;
							
							_keys[ev.key.code] = false;
							break;
							
						case platform.windows.WM_LBUTTONDOWN:
						case platform.windows.WM_RBUTTONDOWN:
						case platform.windows.WM_MBUTTONDOWN:
							_mouseX = platform.windows.LOWORD(lParam);
							_mouseY = platform.windows.HIWORD(lParam);
							
							if (msg == platform.windows.WM_LBUTTONDOWN) ev.mouse.button = MouseButtons.Left;
							else if (msg == platform.windows.WM_RBUTTONDOWN) ev.mouse.button = MouseButtons.Right;
							else if (msg == platform.windows.WM_MBUTTONDOWN) ev.mouse.button = MouseButtons.Middle;
							else break;
							
							ev.type = EventTypes.MouseDown;
							ev.mouse.x = mouseX;
							ev.mouse.y = mouseY;
							
							_mouseButtons[ev.mouse.button] = true;
							break;
							
						case platform.windows.WM_LBUTTONUP:
						case platform.windows.WM_RBUTTONUP:
						case platform.windows.WM_MBUTTONUP:
							_mouseX = platform.windows.LOWORD(lParam);
							_mouseY = platform.windows.HIWORD(lParam);
							
							if (msg == platform.windows.WM_LBUTTONUP) ev.mouse.button = MouseButtons.Left;
							else if (msg == platform.windows.WM_RBUTTONUP) ev.mouse.button = MouseButtons.Right;
							else if (msg == platform.windows.WM_MBUTTONUP) ev.mouse.button = MouseButtons.Middle;
							else break;
							
							ev.type = EventTypes.MouseUp;
							ev.mouse.x = mouseX;
							ev.mouse.y = mouseY;
							
							_mouseButtons[ev.mouse.button] = false;
							break;
							
						case platform.windows.WM_MOUSEWHEEL:
							_mouseX = platform.windows.LOWORD(lParam);
							_mouseY = platform.windows.HIWORD(lParam);
							
							ev.type = EventTypes.MouseWheel;
							ev.mouse.delta = platform.windows.GET_WHEEL_DELTA_WPARAM(wParam) > 0 ? 1 : -1;
							ev.mouse.x = mouseX;
							ev.mouse.y = mouseY;
							break;
							
						case platform.windows.WM_MOUSEMOVE:
							_mouseX = platform.windows.LOWORD(lParam);
							_mouseY = platform.windows.HIWORD(lParam);
							
							ev.type = EventTypes.MouseMove;
							ev.mouse.x = mouseX;
							ev.mouse.y = mouseY;
							break;

						default:
							break;
					}
					
					// Add event to internal queue
					if (ev.type != EventTypes.Unknown) {
						_events ~= ev;
						foreach (child; _children) {
							if (isEventCatagory(EventCatagories.Mouse, ev.type)) {
								if (ev.mouse.x >= child.x && ev.mouse.y >= child.y && ev.mouse.x <= child.x + child.width && ev.mouse.y <= child.y + child.height) {
									child.childEvent(this, ev);
								}
							} else if (isEventCatagory(EventCatagories.Keyboard, ev.type)) {
								if (child == _selectedChild) {
									child.childEvent(this, ev);
								}
							}
						}
					}
					
					return platform.windows.DefWindowProc(cast(void*)_window, msg, wParam, lParam);
				}
			}
		}
	}
}

extern(Windows) protected platform.windows.LRESULT windowEventHandler(platform.windows.HWND hwnd, platform.windows.UINT message, platform.windows.WPARAM wParam, platform.windows.LPARAM lParam) {
	synchronized {
		shared Window window;
		switch (message)
		{
			case platform.windows.WM_CREATE:
				synchronized(rwmWindows)
					window = windows[cast(size_t)((cast(platform.windows.LPCREATESTRUCTA)lParam).lpCreateParams)];
				window.hwnd = cast(shared)hwnd;
				platform.windows.SetWindowLong(hwnd, platform.windows.GWL_USERDATA, cast(int)window.id);
				assert(cast(size_t)(platform.windows.GetWindowLongA(hwnd, platform.windows.GWL_USERDATA)) == window.id);
				return 0;
			case platform.windows.WM_DESTROY:
				platform.windows.PostQuitMessage(0);
				return 0;
			default:
				synchronized(rwmWindows)
					window = windows[cast(size_t)(platform.windows.GetWindowLong(hwnd, platform.windows.GWL_USERDATA))];
				window.hwnd = cast(shared)hwnd;
				assert(window.id == cast(size_t)(platform.windows.GetWindowLong(hwnd, platform.windows.GWL_USERDATA)));
				return window.windowEvent(cast(uint)message, cast(uint)wParam, cast(uint)lParam);
				break;
		}
		
		return platform.windows.DefWindowProcA(hwnd, message, wParam, lParam);
	}
}

Keys translateKey(uint code) {
	switch (code) {
		case platform.windows.VK_SHIFT: return Keys.Shift;
		case platform.windows.VK_MENU: return Keys.Alt;
		case platform.windows.VK_CONTROL: return Keys.Control;
		case platform.windows.VK_OEM_1: return Keys.Semicolon;
		case platform.windows.VK_OEM_2: return Keys.Slash;
		case platform.windows.VK_OEM_PLUS: return Keys.Equals;
		case platform.windows.VK_OEM_MINUS: return Keys.Hyphen;
		case platform.windows.VK_OEM_4: return Keys.LeftBracket;
		case platform.windows.VK_OEM_6: return Keys.RightBracket;
		case platform.windows.VK_OEM_COMMA: return Keys.Comma;
		case platform.windows.VK_OEM_PERIOD: return Keys.Period;
		case platform.windows.VK_OEM_7: return Keys.Quote;
		case platform.windows.VK_OEM_5: return Keys.Backslash;
		case platform.windows.VK_OEM_3: return Keys.Tilde;
		case platform.windows.VK_ESCAPE: return Keys.Escape;
		case platform.windows.VK_SPACE: return Keys.Space;
		case platform.windows.VK_RETURN: return Keys.Enter;
		case platform.windows.VK_BACK: return Keys.Backspace;
		case platform.windows.VK_TAB: return Keys.Tab;
		case platform.windows.VK_PRIOR: return Keys.PageUp;
		case platform.windows.VK_NEXT: return Keys.PageDown;
		case platform.windows.VK_END: return Keys.End;
		case platform.windows.VK_HOME: return Keys.Home;
		case platform.windows.VK_INSERT: return Keys.Insert;
		case platform.windows.VK_DELETE: return Keys.Delete;
		case platform.windows.VK_ADD: return Keys.Add;
		case platform.windows.VK_SUBTRACT: return Keys.Subtract;
		case platform.windows.VK_MULTIPLY: return Keys.Multiply;
		case platform.windows.VK_DIVIDE: return Keys.Divide;
		case platform.windows.VK_PAUSE: return Keys.Pause;
		case platform.windows.VK_LEFT: return Keys.Left;
		case platform.windows.VK_RIGHT: return Keys.Right;
		case platform.windows.VK_UP: return Keys.Up;
		case platform.windows.VK_DOWN: return Keys.Down;
			
		default:
			if (code >= platform.windows.VK_F1 && code <= platform.windows.VK_F12)
				return cast(Keys)(Keys.F1 + code - platform.windows.VK_F1);
			else if (code >= platform.windows.VK_NUMPAD0 && code <= platform.windows.VK_NUMPAD9)
				return cast(Keys)(Keys.Numpad0 + code - platform.windows.VK_NUMPAD0);
			else if (code >= 'A' && code <= 'Z')
				return cast(Keys)(Keys.A + code - 'A');
			else if (code >= '0' && code <= '9')
				return cast(Keys)(Keys.Num0 + code - '0');
	}
	
	return Keys.Unknown;
}