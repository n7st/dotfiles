;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
;(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font" :size 16))
(setq doom-font (font-spec :family "Fira Code Nerd Font" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;(setq doom-theme 'doom-one)
;(setq doom-theme 'doom-ayu-dark)
(setq doom-theme 'doom-challenger-deep)

(setq projectile-project-search-path '("~/Documents/Projects"))
(projectile-discover-projects-in-search-path)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(setq org-agenda-files '("~/org/agenda"))

(setq org-default-notes-file (concat org-directory "/notes.org"))

;; set variable org-local-notes-file locally
(setq org-capture-templates
  '(("t" "Todo" entry (file "~/org/agenda/inbox.org")
      "* TODO %?\n Dated: %u\n Location: %a")
     ))

;; Map "jj" to <Esc> in Vim mode
(setq key-chord-two-keys-delay 0.7)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)

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

(use-package multi-vterm :ensure t)

;(use-package! whitespace
;  :config
;  (setq
;    whitespace-style '(face tabs tab-mark spaces space-mark trailing newline newline-mark)
;    whitespace-display-mappings '(
;      (space-mark   ?\     [?\u00B7]     [?.])
;      (space-mark   ?\xA0  [?\u00A4]     [?_])
;      (tab-mark     ?\t    [?\u00BB ?\t] [?\\ ?\t])))
;  (global-whitespace-mode +1))

(centaur-tabs-mode t)
(global-set-key (kbd "C-<prior>")  'centaur-tabs-backward)
(global-set-key (kbd "C-<next>") 'centaur-tabs-forward)

;; Remap :q to just close buffer (rather than emacs itself)
(global-set-key [remap evil-quit] 'kill-buffer-and-window)

(add-hook 'imenu-after-jump-hook 'nav-flash-show nil t)

(setq fancy-splash-image (concat doom-user-dir "emacs.svg"))

(if (eq initial-window-system 'x) ; if started by emacs command or desktop file
  (toggle-frame-maximized)
  (toggle-frame-fullscreen))


;; Tramp (remote development) configuration {{
(setq tramp-default-method "ssh")
(setq vterm-tramp-shells '(("ssh" "/usr/bin/zsh")))
;; }}

(add-to-list 'tramp-connection-properties
  (list (regexp-quote "/ssh:mike@hadrian:")
    "remote-shell" "/usr/bin/zsh"))
(add-to-list 'tramp-connection-properties
  (list (regexp-quote "/sshx:mike@hadrian:")
    "remote-shell" "/usr/bin/zsh"))
(customize-set-variable 'tramp-encoding-shell "/usr/bin/zsh")

;; Ruby development environment bits {{
(add-hook 'ruby-mode-hook #'rubocop-mode) ;; Enable RuboCop by default in Ruby files
;; }}

;; org-roam {{
(setq org-roam-directory (file-truename "~/org/roam"))
;; }}

;; Ligatures {{
(global-ligature-mode t)
;; }}

(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;; :wq completely closes emacs by default in evil-mode. This overrides that
;; behaviour, ensuring it only terminates the current buffer {{
(evil-ex-define-cmd "wq" 'save-and-kill-this-buffer)
(defun save-and-kill-this-buffer()(interactive)(save-buffer)(kill-current-buffer))
;; }}

;; Custom "SPC" keybindings {{
(map! :leader "fz" 'fzf-find-file)
;; }}

;; Use my PATH
(when (daemonp)
  (exec-path-from-shell-initialize))

;; Org mode helpers
(defun add-hlines (table)
  "Add hlines to a table (by adding a hline to the script's output output)"
  (cl-map 'list
    (lambda (r) (if (and (listp r) (equal (car r) 'hline))
             'hline
             r))
    table))

;; Git config {{
;; Use the GPG agent for signing
(setq epg-gpg-program "gpg")
(setenv "GPG_AGENT_INFO" nil)

;; Magit settings for commit signing
(setq magit-commit-arguments '("--gpg-sign"))
;; }}

;; Override kill-this-buffer to leave the frame open {{
(defun my/kill-this-buffer ()
  "Kill the current buffer without deleting the frame."
  (interactive)
  (kill-buffer (current-buffer)))

(map! :leader
  :desc "Kill buffer" "b k" #'my/kill-this-buffer)
;; }}

(global-set-key (kbd "C-c s") 'flyspell-learn-word-at-point)

(defun flyspell-learn-word-at-point ()
  "Takes the highlighted word at point -- nominally a misspelling -- and inserts it into the personal/private dictionary, such that it is known and recognized as a valid word in the future."
  (interactive)
  (let ((current-location (point))
         (word (flyspell-get-word)))
    (when (consp word)
      (flyspell-do-correct
        'save nil
        (car word)
        current-location
        (cadr word)
        (caddr word)
        current-location))))
