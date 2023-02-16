;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Daniel Whitaker"
      user-mail-address "Dan@uncharted.systems")

(setq +doom-dashboard-banner-file "logo.png"
      +doom-dashboard-banner-dir "~/.doom.d/")

(setq confirm-kill-emacs nil)


;; General Settings

(setq-default
 delete-by-moving-to-trash t            ; Delete files to trash
 tab-width 2                            ; Set width for tabs
 uniquify-buffer-name-style 'forward    ; Uniquify buffer names
 window-combination-resize t            ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                    ; Stretch cursor to the glyph width

(setq undo-limit 80000000               ; Raise undo-limit to 80Mb
      evil-want-fine-undo t             ; By default while in insert all changes are one big blob. Be more granular
      inhibit-compacting-font-caches t  ; When there are lots of glyphs, keep them in memory
      truncate-string-ellipsis "…")     ; Unicode ellispis are nicer than "...", and also save /precious/ space

(delete-selection-mode 1)               ; Replace selection when inserting text
;(display-time-mode 1)                  ; Enable time in the mode-line
;(setq line-spacing 0.3)                ; seems like a nice line spacing balance.

(if (eq initial-window-system 'x)       ; if started by emacs command or desktop file
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

;; Language Server Protocol (LSP) Options

(setq lsp-treemacs-sync-mode 1)
;; (setq lsp-lens-enable t)
;; (setq lsp-ui-doc-enable t)
;; (setq lsp-ui-doc-show-with-cursor t)
;; (setq lsp-ui-doc-show-with-mouse nil)
;; (setq lsp-ui-sideline-enable t)
;; (setq lsp-ui-sideline-show-code-actions t)
;; (setq lsp-modeline-code-actions-enable t)


;; Clojure Settings

;; For debugging empty stack traces!
(setq cider-clojure-cli-global-options "-J-XX:-OmitStackTraceInFastThrow")



;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

(setq
 doom-font (font-spec :family "Ubuntu Mono" :size 20)
 doom-unicode-font (font-spec :family "Ubuntu Mono" :size 20)
 doom-big-font (font-spec :family "Ubuntu Mono" :size 30))

;; Can be used later for conditonally setting font family + size
;; (cond ((eq system-type 'darwin) "on-macos")
;;       ((memq system-type '(cygwin windows-nt ms-dos)) "on-windows")
;;       ("on-linux"))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-vibrant)
(custom-set-faces!
  '(doom-modeline-buffer-modified :foreground "orange"))

;; LF UTF-8 is the default file encoding, and thus not worth noting in the modeline.
;; Let’s conditionally hide it.

(defun doom-modeline-conditional-buffer-encoding ()
  "expected encoding is LF UTF-8: only show modeline when encoding is different"
  (setq-local doom-modeline-buffer-encoding
              (unless (and (memq (plist-get (coding-system-plist buffer-file-coding-system) :category)
                                 '(coding-category-undecided coding-category-utf-8))
                           (not (memq (coding-system-eol-type buffer-file-coding-system) '(1 2))))
                t)))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
