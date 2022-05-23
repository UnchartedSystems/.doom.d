;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Daniel Whitaker"
      user-mail-address "Dan@uncharted.systems")

(setq +doom-dashboard-banner-file "logo.png"
      +doom-dashboard-banner-dir "~/.doom.d/")

(setq confirm-kill-emacs nil)

;; Choice between standard font and custom font per system
;; (setq
;;  doom-font (font-spec :size 16)
;;  doom-big-font (font-spec :size 30)
;;  doom-variable-pitch-font (font-spec :size 15))
(setq doom-font (font-spec :family "." :size 16 :weight 'semi-light))

;; Cider & LSP
(setq lsp-lens-enable t)
(setq cider-clojure-cli-global-options "-J-XX:-OmitStackTraceInFastThrow")
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-ui-doc-show-with-mouse nil)
(setq lsp-lens-enable t)
(setq lsp-ui-sideline-enable t)
(setq lsp-ui-sideline-show-code-actions t)
(setq lsp-ui-sideline-enable t)
(setq lsp-modeline-code-actions-enable t)

;; (use-package! cider
;;   :after clojure-mode
;;   :config
;;   (set-lookup-handlers! 'cider-mode nil))

(use-package! clj-refactor
  :after clojure-mode
  :config
  (set-lookup-handlers! 'clj-refactor-mode nil))
;; Hoplon

(add-to-list 'auto-mode-alist '("\\.cljs\\.hl\\'"  clojurescript-mode))

(add-hook 'clojure-mode-hook
          '(lambda ()
             ;; Hoplon functions and macros
             (dolist (pair '((page . 'defun)
                             (loop-tpl . 'defun)
                             (if-tpl . '1)
                             (for-tpl . '1)
                             (case-tpl . '1)
                             (cond-tpl . 'defun)))
               (put-clojure-indent (car pair)
                                   (car (last pair))))))

;; Rust & LSP
(setq rustic-lsp-server 'rust-analyzer)
(setq lsp-rust-analyzer-server-command '("~/.cargo/bin/rust-analyzer"))


(setq-default
 delete-by-moving-to-trash t            ; Delete files to trash
 tab-width 2                            ; Set width for tabs
 uniquify-buffer-name-style 'forward    ; Uniquify buffer names
 window-combination-resize t ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                      ; Stretch cursor to the glyph width

(setq undo-limit 80000000                 ; Raise undo-limit to 80Mb
      evil-want-fine-undo t               ; By default while in insert all changes are one big blob. Be more granular
      inhibit-compacting-font-caches t    ; When there are lots of glyphs, keep them in memory
      truncate-string-ellipsis "…")       ; Unicode ellispis are nicer than "...", and also save /precious/ space

(delete-selection-mode 1)                 ; Replace selection when inserting text
;(display-time-mode 1)                    ; Enable time in the mode-line
;(setq line-spacing 0.3)                  ; seems like a nice line spacing balance.

(if (eq initial-window-system 'x)         ; if started by emacs command or desktop file
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

;; the following code allows me to choose which buffer I want to see when I split a window.
;; It first does a split to the right, and then opens Ivy and and shows me a preview

(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)

(setq lsp-treemacs-sync-mode 1)


;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
