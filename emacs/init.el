;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; General
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 環境を日本語、UTF-8にする
(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)

;; バックアップファイルを作成させない
(setq make-backup-files nil)

;; 終了時にオートセーブファイルを削除する
(setq delete-auto-save-files t)

;; タブにスペースを使用する
(setq-default tab-width 4 indent-tabs-mode nil)

;; タブ幅
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-disabled-checkers (quote (javascript-jshint javascript-jscs)))
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(package-selected-packages
   (quote
    (company-tern company flycheck-pos-tip flycheck-pos-check flycheck js2-mode powerline markdown-preview-mode atom-one-dark-theme atom-one-dark-teme yatex yaml-mode markdown-mode)))
 '(tab-width 4))

;; スクロールは１行ごとに
(setq scroll-conservatively 1)

;; 選択領域を入力で置き換える
(delete-selection-mode 1)

;; C-kで行全体を削除する
(setq kill-whole-line t)

;; "yes or no" の選択を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)

;; beep音を消す
(defun my-bell-function ()
  (unless (memq this-command
        '(isearch-abort abort-recursive-edit exit-minibuffer
              keyboard-quit mwheel-scroll down up next-line previous-line
              backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

;; ファイル自動読み込み
(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive) (revert-buffer t t))
(global-set-key (kbd "C-c C-r") 'revert-buffer-no-confirm)
(global-auto-revert-mode 1)

;; 閉じカッコの自動挿入
(electric-pair-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Proxy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ロードパスの追加
(setq load-path (append
                 '("~/.emacs.d/private-conf")
                 load-path))

;; proxy設定
;; private-conf/myproxy.elがあるときだけプロキシ設定をロード
;; 第2引数のtをつけると、ファイルが存在しなくてもエラーにならない
(load "myproxy" t)

;;
;; package.el関係
;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(package-initialize)
(package-refresh-contents)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Design
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Remove menu bar
(menu-bar-mode -1)

;; ツールバーを消す
(tool-bar-mode -1)

;; Show column number
(column-number-mode t)

;; Show row number
(global-linum-mode t)

;; Stop flashing cursor
(blink-cursor-mode 0)

;; Flashing corresponding brackets
(show-paren-mode 1)

;; Show full path of a file on opening buffer
;;;; File-Info - ファイル情報
;;;====================================
;;; 2007年12月29日(土曜日) 21:07:43 JST
;;; カレントバッファのファイル情報を表示する。
(defun file-info () "
カレントバッファのファイル情報を表示する。"
  (interactive)
  (if (buffer-file-name (current-buffer))
      (progn
        (let* ((file-name (buffer-file-name (current-buffer)))
               (f-attr (file-attributes file-name))
               (a-time (nth 4 f-attr))  ; 最終アクセス時刻
               (m-time (nth 5 f-attr))  ; 最終修正時刻
               (f-size (nth 7 f-attr))  ; ファイルサイズ
               (f-mode (nth 8 f-attr))  ; ファイル属性
               (mes1 (format "ファイルパス:   %s\n" file-name))
               (mes2 (format "最終参照時刻:   %s\n"
                              (format-time-string
                               "%Y-%m-%d %H:%M:%S" a-time)))
               (mes3 (format "最終修正時刻:   %s\n"
                              (format-time-string
                               "%Y-%m-%d %H:%M:%S" m-time)))
               (mes4 (format "ファイルサイズ: %s byte\n" f-size))
               (mes5 (format "ファイル属性:   %s" f-mode))
               (mess (concat mes1 mes2 mes3 mes4 mes5)))
          (message "%s" mess)))
    nil ))

(global-set-key "\C-ci" 'file-info)          ; file情報を表示する。

;; Color theme
(package-install 'atom-one-dark-theme)
(load-theme 'atom-one-dark t)


;; Powerline
(unless (package-installed-p 'powerline)
  (package-refresh-contents) (package-install 'powerline))
(require 'powerline)

(defun powerline-my-theme ()
  "Setup the my mode-line."
  (interactive)
  (setq powerline-current-separator 'utf-8)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'mode-line-1-fg 'mode-line-2-fg))
                          (face2 (if active 'mode-line-1-arrow 'mode-line-2-arrow))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (lhs (list (powerline-raw " " face1)
                                     (powerline-major-mode face1)
                                     (powerline-raw " " face1)
                                     (funcall separator-left face1 face2)
                                     (powerline-buffer-id nil )
                                     (powerline-raw " [ ")
                                     (powerline-raw mode-line-mule-info nil)
                                     (powerline-raw "%*")
                                     (powerline-raw " |")
                                     (powerline-process nil)
                                     (powerline-vc)
                                     (powerline-raw " ]")
                                     ))
                          (rhs (list (powerline-raw "%4l")
                                     (powerline-raw ":")
                                     (powerline-raw "%2c")
                                     (powerline-raw " | ")                                  
                                     (powerline-raw "%6p")
                                     (powerline-raw " ")
                                     )))
                     (concat (powerline-render lhs)
                             (powerline-fill nil (powerline-width rhs)) 
                             (powerline-render rhs)))))))

(defun make/set-face (face-name fg-color bg-color weight)
  (make-face face-name)
  (set-face-attribute face-name nil
                      :foreground fg-color :background bg-color :box nil :weight weight))
(make/set-face 'mode-line-1-fg "#282C34" "#EF8300" 'bold)
(make/set-face 'mode-line-2-fg "#AAAAAA" "#2F343D" 'bold)
(make/set-face 'mode-line-1-arrow  "#AAAAAA" "#3E4451" 'bold)
(make/set-face 'mode-line-2-arrow  "#AAAAAA" "#3E4451" 'bold)

(powerline-my-theme)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Package install and settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; Markdown
;;

(unless (package-installed-p 'markdown-mode)
  (package-refresh-contents) (package-install 'markdown-mode))
(unless (package-installed-p 'markdown-preview-mode)
  (package-refresh-contents) (package-install 'markdown-preview-mode))

;;
;; YaTeX
;;

(unless (package-installed-p 'yatex)
  (package-refresh-contents) (package-install 'yatex))
(add-to-list 'load-path "~/.emacs.d/site-lisp/yatex")
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
                ("\\.ltx$" . yatex-mode)
                ("\\.cls$" . yatex-mode)
                ("\\.sty$" . yatex-mode)
                ("\\.clo$" . yatex-mode)
                ("\\.bbl$" . yatex-mode)) auto-mode-alist))
(setq YaTeX-inhibit-prefix-letter t)
(setq YaTeX-kanji-code nil)
(setq YaTeX-latex-message-code 'utf-8)
(setq YaTeX-use-LaTeX2e t)
(setq YaTeX-use-AMS-LaTeX t)
(setq YaTeX-dvi2-command-ext-alist
      '(("TeXworks\\|texworks\\|texstudio\\|mupdf\\|SumatraPDF\\|Preview\\|Skim\\|TeXShop\\|evince\\|atril\\|xreader\\|okular\\|zathura\\|qpdfview\\|Firefox\\|firefox\\|chrome\\|chromium\\|MicrosoftEdge\\|microsoft-edge\\|Adobe\\|Acrobat\\|AcroRd32\\|acroread\\|pdfopen\\|xdg-open\\|open\\|start" . ".pdf")))
(setq tex-command "ptex2pdf -u -l -ot '-synctex=1'")
                                        ;(setq tex-command "lualatex -synctex=1")
                                        ;(setq tex-command "latexmk")
                                        ;(setq tex-command "latexmk -e '$latex=q/uplatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex %O -o %D %S/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
                                        ;(setq tex-command "latexmk -e '$lualatex=q/lualatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex %O -o %D %S/' -norc -gg -pdflua")
(setq bibtex-command "latexmk -e '$latex=q/uplatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex %O -o %D %S/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
(setq makeindex-command  "latexmk -e '$latex=q/uplatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex %O -o %D %S/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
                                        ;(setq dvi2-command "xdg-open")
(setq dvi2-command "evince")
                                        ;(setq dvi2-command "atril")
                                        ;(setq dvi2-command "okular --unique")
                                        ;(setq dvi2-command "zathura -x \"emacsclient --no-wait +%{line} %{input}\"")
                                        ;(setq dvi2-command "qpdfview --unique")
                                        ;(setq dvi2-command "texworks")
                                        ;(setq dvi2-command "texstudio --pdf-viewer-only")
                                        ;(setq tex-pdfview-command "xdg-open")
(setq tex-pdfview-command "evince")
                                        ;(setq tex-pdfview-command "atril")
                                        ;(setq tex-pdfview-command "okular --unique")
                                        ;(setq tex-pdfview-command "zathura -x \"emacsclient --no-wait +%{line} %{input}\"")
                                        ;(setq tex-pdfview-command "qpdfview --unique")
                                        ;(setq tex-pdfview-command "texworks")
                                        ;(setq tex-pdfview-command "texstudio --pdf-viewer-only")
(setq dviprint-command-format "wine cmd /c start AcroRd32.exe `echo %s | sed -e \"s/\\.[^.]*$/\\.pdf/\"`")

(require 'dbus)

(defun un-urlify (fname-or-url)
  "A trivial function that replaces a prefix of file:/// with just /."
  (if (string= (substring fname-or-url 0 8) "file:///")
      (substring fname-or-url 7)
    fname-or-url))

(defun evince-inverse-search (file linecol &rest ignored)
  (let* ((fname (decode-coding-string (url-unhex-string (un-urlify file)) 'utf-8))
         (buf (find-file fname))
         (line (car linecol))
         (col (cadr linecol)))
    (if (null buf)
        (message "[Synctex]: %s is not opened..." fname)
      (switch-to-buffer buf)
      (goto-line (car linecol))
      (unless (= col -1)
        (move-to-column col))
      (x-focus-frame (selected-frame)))))

(with-eval-after-load 'yatexprc
  (defun YaTeX-preview-jump-line ()
    "Call jump-line function of various previewer on current main file"
    (interactive)
    (save-excursion
      (save-restriction
        (widen)
        (let*((pf (or YaTeX-parent-file
                      (save-excursion (YaTeX-visit-main t) (buffer-file-name))))
              (pdir (file-name-directory pf))
              (bnr (substring pf 0 (string-match "\\....$" pf)))
                                        ;(cf (file-relative-name (buffer-file-name) pdir))
              (cf (buffer-file-name)) ;2016-01-08
              (buffer (get-buffer-create " *preview-jump-line*"))
              (line (count-lines (point-min) (point-end-of-line)))
              (previewer (YaTeX-preview-default-previewer))
              (cmd (cond
                    ((string-match "Skim" previewer)
                     (format "%s %d '%s.pdf' '%s'"
                             YaTeX-cmd-displayline line bnr cf))
                    ((string-match "evince" previewer)
                     (format "%s '%s.pdf' %d '%s'"
                             "fwdevince" bnr line cf))
                    ((string-match "sumatra" previewer)
                     (format "%s \"%s.pdf\" -forward-search \"%s\" %d"
                             previewer bnr cf line))
                    ((string-match "zathura" previewer)
                     (format "%s --synctex-forward '%d:0:%s' '%s.pdf'"
                             previewer line cf bnr))
                    ((string-match "qpdfview" previewer)
                     (format "%s '%s.pdf#src:%s:%d:0'"
                             previewer bnr cf line))
                    ((string-match "okular" previewer)
                     (format "%s '%s.pdf#src:%d %s'"
                             previewer bnr line (expand-file-name cf)))
                    )))
          (YaTeX-system cmd "jump-line" 'noask pdir))))))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (auto-fill-mode -1)))

;;
;; RefTeX with YaTeX
;;
                                        ;(add-hook 'yatex-mode-hook 'turn-on-reftex)
(add-hook 'yatex-mode-hook
          '(lambda ()
             (reftex-mode 1)
             (define-key reftex-mode-map (concat YaTeX-prefix ">") 'YaTeX-comment-region)
                          (define-key reftex-mode-map (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;
;; JavaScript
;;

(unless (package-installed-p 'js2-mode)
  (package-refresh-contents) (package-install 'js2-mode))

;; js2-mode
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))


;;
;; Flycheck
;;

(unless (package-installed-p 'flycheck)
  (package-refresh-contents) (package-install 'flycheck))
(unless (package-installed-p 'flycheck-pos-tip)
  (package-refresh-contents) (package-install 'flycheck-pos-tip))

;;; Hook target
;;;; .jsのファイルで js2-mode を使う
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;;; js2-mode を使う時には flycheck-mode も使う
(add-hook 'js2-mode-hook #'flycheck-mode)

;;;
(eval-after-load 'flycheck
  '(custom-set-variables
   '(flycheck-disabled-checkers '(javascript-jshint javascript-jscs))))
(eval-after-load 'flycheck
  '(custom-set-variables
   '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
(setq js2-include-browser-externs nil)
(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)
(setq js2-higlight-external-variables nil)
(setq js2-include-jslint-globals nil)

;;;
;;; 補完ツール
;;;

(package-install 'company)
(package-install 'company-tern)

(require 'company)
(global-company-mode)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 2)
(setq company-selection-wrap-around t)
