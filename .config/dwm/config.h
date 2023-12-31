/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx = 2; /* border pixel of windows */
static const unsigned int gappx = 20;   /* gaps between windows */
static const unsigned int snap = 10;    /* snap pixel */
static const int showbar = 1;           /* 0 means no bar */
static const int topbar = 1;            /* 0 means bottom bar */
static const int horizpadbar = 6;       /* horizontal padding for statusbar */
static const int vertpadbar = 7;        /* vertical padding for statusbar */
static const int usealtbar = 1;         /* 1 means use non-dwm status bar */
static const int swallowfloating =
    0; /* 1 means swallow floating windows by default */
static const char *altbarclass = "Polybar"; /* Alternate bar class name */
static const char *alttrayname = "tray";    /* Polybar tray instance name */
static const char *altbarcmd =
    "$HOME/bin/polybar-dwm"; /* Alternate bar launch command */

static const char *fonts[] = {
    "Ubuntu:weight=bold:size=8:antialias=true:hinting=true",
    "Hack:size=8:antialias=true:autohint=true",
    "JoyPixels:size=10:antialias=true:autohint=true"};
static const char col_1[] = "#282c34"; /* background color of bar */
static const char col_2[] = "#424242"; /* border color unfocused windows */
static const char col_3[] = "#d7d7d7";
static const char col_4[] =
    "#806080"; /* border color focused windows and tags */

static const unsigned int baralpha = 0x80;
static const unsigned int borderalpha = OPAQUE;
static const char *colors[][3] = {
    /*               fg     bg     border   */
    [SchemeNorm] = {col_3, col_1, col_2},
    [SchemeSel] = {col_3, col_4, col_4},
};
static const unsigned int alphas[][3] = {
    /*               fg      bg        border     */
    [SchemeNorm] = {OPAQUE, baralpha, borderalpha},
    [SchemeSel] = {OPAQUE, baralpha, borderalpha},
};

/* tagging */
static const char *tags[] = {"1: 󰆍", "2: 󰖟", "3: 󱌣", "4: 󱤙",
                             "5: 󰵝"};

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class 
     * instance
     * title
     * tags mask
     * isfloating
     * isterminal
     * noswallow
     * monitor */
    {"Dragon-drop",     NULL,       NULL,           0,      1, 0, 1, -1},
    {"kitty",           NULL,       NULL,           0,      0, 1, 0, -1},
    {"Thunar",          NULL,       NULL,           0,      0, 1, 0, -1},
    {"Gimp",            NULL,       NULL,           0,      1, 0, 0, -1},
    {"ffxiv_dx11.exe",  NULL,       NULL,           1 << 3, 0, 0, 0, -1},
    {NULL,              NULL,       "Event Tester", 0,      0, 0, 1, -1}, /* xev */
};

/* layout(s) */
static const float mfact = 0.6; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;   /* number of clients in master area */
static const int resizehints =
    0; /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen =
    1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    {" 󱇚 ", tile}, /* first entry is default */
    {" 󰉧 ", NULL}, /* no layout function means floating behavior */
    {" 󱁵 ", monocle},
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                       \
      {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},               \
      {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                        \
      {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }

/* commands */
static char dmenumon[2] =
    "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *termcmd[]       = {"kitty", NULL};
static const char *dmenucmd[]      = {"launcher", NULL};
static const char *powercmd[]      = {"powermenu", NULL};
static const char *sshotcmd[]      = {"screenshot", NULL};
static const char *filemanager[]   = {"thunar", NULL};
static const char scratchpadname[] = "scratchpad";
static const char *scratchpadcmd[] = {"kitty", "-T", scratchpadname, NULL};

static const char *musictoggle[]  = {"mpc", "toggle", NULL};
static const char *musicnext[]    = {"mpc", "next", NULL};
static const char *musicprev[]    = {"mpc", "prev", NULL};

static const char *upvol[]        = {"/usr/bin/pactl", "set-sink-volume", "0", "+5%", NULL};
static const char *downvol[]      = {"/usr/bin/pactl", "set-sink-volume", "0", "-5%", NULL};
static const char *mutevol[]      = {"/usr/bin/pactl", "set-sink-mute", "0", "toggle", NULL};

static const Key keys[] = {
    /* modifier                     key        function        argument */
    {MODKEY, XK_Right, view_adjacent, {.i = +1}},
    {MODKEY, XK_Left, view_adjacent, {.i = -1}},
    {MODKEY, XK_Return, spawn, {.v = termcmd}},
    {MODKEY, XK_w, togglescratch, {.v = scratchpadcmd}},
    {MODKEY | ShiftMask, XK_Return, spawn, {.v = dmenucmd}},
    {MODKEY, XK_e, spawn, {.v = filemanager}},
    {MODKEY, XK_l, spawn, {.v = powercmd}},
    {0, XK_Print, spawn, {.v = sshotcmd}},
    {0, XF86XK_AudioPlay, spawn, {.v = musictoggle}},
    {0, XF86XK_AudioNext, spawn, {.v = musicnext}},
    {0, XF86XK_AudioPrev, spawn, {.v = musicprev}},
    {0, XF86XK_AudioRaiseVolume, spawn, {.v = upvol}},
    {0, XF86XK_AudioLowerVolume, spawn, {.v = downvol}},
    {0, XF86XK_AudioMute, spawn, {.v = mutevol}},
    {MODKEY, XK_b, togglebar, {0}},
    {MODKEY, XK_j, focusstack, {.i = +1}},
    {MODKEY, XK_k, focusstack, {.i = -1}},
    {MODKEY, XK_i, incnmaster, {.i = +1}},
    {MODKEY, XK_d, incnmaster, {.i = -1}},
    {MODKEY | ShiftMask, XK_h, setmfact, {.f = -0.05}},
    {MODKEY | ShiftMask, XK_l, setmfact, {.f = +0.05}},
    {MODKEY, XK_z, zoom, {0}},
    {MODKEY, XK_Tab, view, {0}},
    {MODKEY | ShiftMask, XK_c, killclient, {0}},
    {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
    {MODKEY, XK_f, setlayout, {.v = &layouts[1]}},
    {MODKEY, XK_m, setlayout, {.v = &layouts[2]}},
    {MODKEY, XK_space, setlayout, {0}},
    {MODKEY | ShiftMask, XK_space, togglefloating, {0}},
    {MODKEY, XK_0, view, {.ui = ~0}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
    {MODKEY, XK_comma, focusmon, {.i = -1}},
    {MODKEY, XK_period, focusmon, {.i = +1}},
    {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
    {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
        TAGKEYS(XK_5, 4){MODKEY | ShiftMask, XK_r, quit, {1}},
    {MODKEY | Mod1Mask, XK_q, quit, {0}},
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
    /* click                event mask      button          function argument */
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button2, spawn, {.v = termcmd}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button3, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button2, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
    {ClkTagBar, 0, Button4, view_adjacent, {.i = -1}},
    {ClkTagBar, 0, Button5, view_adjacent, {.i = +1}},
};

static const char *ipcsockpath = "/tmp/dwm.sock";
static IPCCommand ipccommands[] = {
    IPCCOMMAND(view, 1, {ARG_TYPE_UINT}),
    IPCCOMMAND(toggleview, 1, {ARG_TYPE_UINT}),
    IPCCOMMAND(tag, 1, {ARG_TYPE_UINT}),
    IPCCOMMAND(toggletag, 1, {ARG_TYPE_UINT}),
    IPCCOMMAND(tagmon, 1, {ARG_TYPE_UINT}),
    IPCCOMMAND(focusmon, 1, {ARG_TYPE_SINT}),
    IPCCOMMAND(focusstack, 1, {ARG_TYPE_SINT}),
    IPCCOMMAND(zoom, 1, {ARG_TYPE_NONE}),
    IPCCOMMAND(incnmaster, 1, {ARG_TYPE_SINT}),
    IPCCOMMAND(killclient, 1, {ARG_TYPE_SINT}),
    IPCCOMMAND(togglefloating, 1, {ARG_TYPE_NONE}),
    IPCCOMMAND(setmfact, 1, {ARG_TYPE_FLOAT}),
    IPCCOMMAND(setlayoutsafe, 1, {ARG_TYPE_PTR}),
    IPCCOMMAND(quit, 1, {ARG_TYPE_NONE})};
