#include "win32_window_manager.h"

win32_window_manager::win32_window_manager() {
    // do nothing.
}
bool win32_window_manager::update() {
    char wnd_title[256];
    char wnd_class[256];
    RECT tempRect;
    currentWindow = GetForegroundWindow(); // get handle of currently active window
    GetWindowText(currentWindow, wnd_title, sizeof(wnd_title));
    GetClassName(currentWindow, wnd_class, sizeof(wnd_class));
    GetWindowRect(currentWindow, &tempRect);
    std::string tempStr;
    tempStr.assign(wnd_class);
    if (tempStr == "") {
        return false;
    } else {
        active_window_class.assign(wnd_class);
        active_window_name.assign(wnd_title);
        focusedWindowX = tempRect.left;
        focusedWindowY = tempRect.top;
        focusedWindowWidth = tempRect.right - tempRect.left;
        focusedWindowHeight = tempRect.bottom - tempRect.top;
        return true;
    }
}
bool win32_window_manager::is_currently_active_window_owned_by_us() {
    HWND temp_win = GetForegroundWindow();
    char temp_win_class[256];
    GetClassName(temp_win, temp_win_class, sizeof(temp_win_class));
    std::string tempStr;

    tempStr.assign(temp_win_class);
    std::cout << tempStr << std::endl;
    if (tempStr == "FLTK") {
        return true;
    } else {
        return false;
    }
}
void win32_window_manager::toggle_window_state(bool shouldUpdate) {

}
void win32_window_manager::minimize_active_window() {
    PostMessage(currentWindow, WM_SYSCOMMAND, SC_MINIMIZE, 0);
}
void win32_window_manager::show_active_window() {
    PostMessage(currentWindow, WM_SYSCOMMAND, SC_RESTORE, 0);
}
void win32_window_manager::bring_nml_hidden_to_front(Fl_Window* win) {
    char temp_win_name[256];
    // apparently, the windows API doesn't let users do this, so I have to allow myself to set the foreground window first
    HWND winapiWindow = fl_xid(win);
    GetWindowText(winapiWindow, temp_win_name, sizeof(temp_win_name));
    std::cout << "bringing " << temp_win_name << " to front" << std::endl;
    /*AttachThreadInput(GetWindowThreadProcessId(winapiWindow), GetWindowThreadProcessId(currentWindow))*/;
    AllowSetForegroundWindow(GetWindowThreadProcessId(winapiWindow));
    SetForegroundWindow(winapiWindow);
    SetActiveWindow(winapiWindow);


}
