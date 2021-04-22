import XMonad
import System.IO (hPutStrLn)
import System.Exit

import XMonad.Actions.TreeSelect
import XMonad.Actions.CopyWindow

import XMonad.Layout (Mirror, Tall)
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Spacing
import XMonad.Layout.TwoPane
-- import XMonad.Layout.Fullscreen
import XMonad.Layout.ShowWName

-- import           XMonad.Config.Kde
import XMonad.Hooks.DynamicLog (dynamicLogString, dynamicLogWithPP, xmobarPP, PP(..))
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.WorkspaceHistory

import qualified XMonad.StackSet as W
import qualified Data.Map as M
import Data.Tree

import XMonad.Prompt
import XMonad.Prompt.Shell

import XMonad.Util.NamedScratchpad
import XMonad.Util.NamedWindows
import XMonad.Util.Run (spawnPipe, safeSpawn)
import XMonad.Util.SpawnOnce
import XMonad.Util.Scratchpad
import XMonad.Util.Themes

myManageHook = composeAll
  [ className =? "plasmashell"  --> doFloat
  , className =? "Firefox" <&&> resource =? "Toolkit" --> doFloat
--  , className =? "KeePassXC" --> doShift "9"
  , className =? "Emacs" --> doShift "3:emacs"
  , className =? "jetbrains-toolbox" --> doFloat
  , className =? "jetbrains-clion" --> doFloat
  , className =? "krunner" --> doIgnore >> doFloat
  , className =? "VirtualBox Manager" --> doFloat
  ]

myStartupHook :: X ()
myStartupHook = do
  -- for Java GUI programs; see http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=6429775
  setWMName "LG3D"

  spawnOnce "lxpolkit"
  spawnOnce "plank &"
  spawnOnce "trayer --edge top --align right --widthtype request --SetDockType true &"
  spawnOnce "dunst &"
  spawnOnce "nitrogen --restore &"
  spawnOnce "picom &"
--  spawnOnce "nm-applet &"
  spawnOnce "~/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox --minimize &"
  spawnOnce "/usr/bin/nextcloud &"
--  spawnOnce "/usr/bin/keepassxc &"
  spawnOnce "emacs &"
  spawnOnce "firefox &"

myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
  where fadeAmount = 0.9

myTerminal :: String
myTerminal = "alacritty"

myBlaScratchPadHook :: ManageHook
myBlaScratchPadHook = scratchpadManageHook (W.RationalRect l t w h)
  where
    h = 0.1
    w = 1
    t = 1 - h
    l = 1 - w

myLayouts =
  smartBorders $
  spacingRaw True (Border 0 0 0 0) False (Border 10 10 10 10) True $
  noBorders (tabbed shrinkText (theme kavonChristmasTheme))
  ||| noBorders Full
  ||| TwoPane (3/100) (1/2)
  ||| Tall 1 (10/100) (60/100)
  ||| Mirror (Tall 1 (10/100) (60/100))

main = do
  xmproc <- spawnPipe "xmobar -x 0 ~/.xmobarrc"

  xmonad
--    $ fullscreenSupport
    $ docks
    $ ewmh
    def
         { terminal   = myTerminal
         , handleEventHook = handleEventHook def <+> fullscreenEventHook
         , borderWidth = 2
--         , normalBorderColor = "#00ff00"
         , focusedBorderColor = "#ff0000"
         , focusFollowsMouse = False
         , clickJustFocuses = True
--         , workspaces = toWorkspaces myWorkspaces -- ["1:web","2:dev","3:emacs","4","5:shell","6", "7", "8", "9"] ++ toWorkspaces myWorkspaces
         , workspaces = ["1:web","2:dev","3:emacs","4","5:shell","6", "7", "8", "9"]
         , modMask    = mod4Mask
         , keys = myKeys
         , startupHook = myStartupHook
         , logHook = myLogHook <+> workspaceHistoryHook <+> dynamicLogWithPP xmobarPP
         { ppOutput = \x -> hPutStrLn xmproc x
         , ppUrgent = \x -> x ++ "!"
         , ppHidden = \x -> if x == "NSP" then "" else x
--         , ppWsSep = "||"
         }
         , manageHook = manageDocks
           <+> ( isFullscreen --> doFullFloat )
           <+> namedScratchpadManageHook scratchpads <+> myManageHook
--           <+> fullscreenManageHook
--         , layoutHook = avoidStruts (layoutHook def)
         , layoutHook = smartBorders . avoidStruts . showWName $ myLayouts
    }

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

  -- launch terminal
  [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

  , ((modm, xK_space), spawn "rofi -show combi -modi combi  -show-icons -theme solarized -font 'Cascadia Code 18'")

  -- close focused window on current workspace
  , ((modm .|. shiftMask, xK_c), kill1)

  -- rotate through available layout algorithms
  , ((modm, xK_Menu), sendMessage NextLayout)

  -- reset laouts on current workspace to default
  , ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)

  -- move focus to next window
  , ((modm, xK_Tab), windows W.focusDown)

  -- move focus to next window
  , ((modm, xK_j), windows W.focusDown)

  -- move focus to previous window
  , ((modm, xK_k), windows W.focusUp)

  -- move focus to master window
  , ((modm, xK_m), windows W.focusMaster)

  -- swap focused and master window
  , ((modm, xK_Return), windows W.swapMaster)

  -- swap focused with next window
  , ((modm .|. shiftMask, xK_j), windows W.swapDown)

  -- swap focused with previous window
  , ((modm .|. shiftMask, xK_k), windows W.swapUp)

  -- shrink master area
  , ((modm, xK_h), sendMessage Shrink)

  -- expand master area
  , ((modm, xK_l), sendMessage Expand)

  -- push window back into tiling
  , ((modm, xK_t), withFocused $ windows . W.sink)

  -- increment number of windows in master area
  , ((modm, xK_comma), sendMessage (IncMasterN 1))

  -- decrement number of windows in master area
  , ((modm, xK_period), sendMessage (IncMasterN (-1)))

  -- restart xmonad
  , ((modm, xK_q), spawn "xmonad --recompile ; xmonad --restart")

  -- copy to all workspaces
--  , ((modm, xK_d), windows copyToAll)

  -- kill all other copies
--  , ((modm .|. shiftMask, xK_d), killAllOtherCopies)

  , ((modm, xK_s), scratchpadSpawnActionTerminal "")

  -- Quit xmonad
  , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

--  , ((modm .|. shiftMask, xK_slash), spawn ("echo howdy | xmessage -file -"))
  ]

  ++

  -- mod-[1..9]  switch to workspace N
  -- mod-shift-[1..9]  move client to workspace N
  [
    ((m .|. modm, k), windows $f i)
      | (i, k) <- zip (XMonad.workspaces conf) [ xK_1 .. xK_9 ]
      , (f, m) <- [ (W.greedyView, 0), (W.shift, shiftMask), (copy, shiftMask .|. controlMask) ]
  ]


  ++

--  [ ((controlMask .|. mod1Mask, xK_Return), namedScratchpadAction scratchpads "terminal")
  [ ((controlMask .|. mod1Mask, xK_Return), shellPrompt def)
  , ((controlMask .|. mod1Mask, xK_space), namedScratchpadAction scratchpads "keepassxc")
  ]

  ++

  [ ((modm, xK_f), treeselectWorkspace tsDefaultConfig myWorkspaces W.greedyView)
  , ((modm, xK_a), treeselectAction tsDefaultConfig myActions)

  -- make focused window visible in all workspaces
  , ((modm .|. shiftMask, xK_v), windows copyToAll)

  -- remove focues window from other workspaces
  , ((modm .|. shiftMask .|. controlMask, xK_v), killAllOtherCopies)
  ]

-- see also https://www.youtube.com/watch?v=lQ5NQy_cUdw
scratchpads :: [NamedScratchpad]
scratchpads = [ NS "terminal" spawnTerm findTerm manageTerm
              , NS "keepassxc" spawnKeepassxc findKeepassxc manageKeepassxc
              , NS "emacs-scratch" spawnEmacsScratch findEmacsScratch manageEmacsScratch
              ]
  where
    spawnTerm = myTerminal ++ " -name scratchpad"
    findTerm = resource =? "scratchpad"
    manageTerm = nonFloating

    spawnKeepassxc = "keepassxc"
    findKeepassxc = className =? "KeePassXC"
    manageKeepassxc = defaultFloating
    
    findEmacsScratch = title =? "emacs-scratch"
    spawnEmacsScratch = "emacsclient -a'' -nc -F='(quote (name . \"emacs-scratch\"))'"
--    spawnEmacsScratch = "top"
    manageEmacsScratch = nonFloating


-- desktop notifications

data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
  urgencyHook LibNotifyUrgencyHook w = do
    name <- getName w
    Just idx <- fmap (W.findTag w) $ gets windowset

    safeSpawn "notify-send" [show name, "workspace " ++ idx]

-- treeselect
-- see also https://hackage.haskell.org/package/xmonad-contrib-0.16/docs/XMonad-Actions-TreeSelect.html
-- see also https://www.youtube.com/watch?v=YxyRYZwudYs

myWorkspaces :: Forest String
myWorkspaces = [ Node "1:web" [] -- a workspace for your browser
               , Node "2:dev" []
               , Node "Home"       -- for everyday activity's
                   [ Node "1" []   --  with 4 extra sub-workspaces, for even more activity's
                   , Node "2" []
                   , Node "3" []
                   , Node "4" []
                   ]
               , Node "Programming" -- for all your programming needs
                   [ Node "Haskell" []
                   , Node "Docs"    [] -- documentation
                   ]
               ]

myActions =
  [
   Node (TSNode "Hello"    "displays hello"      (spawn "xmessage hello!")) []
   , Node (TSNode "Hibernate" "schlafen gehen" (spawn "systemctl hibernate")) []
   , Node (TSNode "Shutdown" "Poweroff the system" (spawn "shutdown")) []
   , Node (TSNode "Brightness" "Sets screen brightness using xbacklight" (return ()))
       [ Node (TSNode "Bright" "FULL POWER!!"            (spawn "xbacklight -set 100")) []
       , Node (TSNode "Normal" "Normal Brightness (50%)" (spawn "xbacklight -set 50"))  []
       , Node (TSNode "Dim"    "Quite dark"              (spawn "xbacklight -set 10"))  []
       ]
   ]
