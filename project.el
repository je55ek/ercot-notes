(require 'ox-publish)
(require 'org-re-reveal)

(defun org-reveal-publish-to-html (plist filename pub-dir)
  (org-publish-org-to 're-reveal filename ".html" plist pub-dir))

(setq org-re-reveal-revealjs-version "4")
(setq org-re-reveal-title-slide nil)

(let ((org-dir (expand-file-name "./org/"))
      (site-dir (expand-file-name "./generated")))
  (setq org-publish-project-alist
        `(("ercot-notes-org"
	         :base-directory ,org-dir
           :exclude ".*org"
	         :include ("ercot.org")
	         :publishing-directory ,site-dir
	         :recursive t
	         :publishing-function org-reveal-publish-to-html)
	        ("ercot-notes-static"
	         :base-directory ,org-dir
	         :base-extension "json\\|css\\|js\\|svg\\|png\\|jpg"
	         :publishing-directory ,site-dir
	         :recursive t
	         :publishing-function org-publish-attachment)
	        ("ercot-notes"
	         :components ("ercot-notes-org"
		                    "ercot-notes-static")))))

(defun my-org-confirm-babel-evaluate (lang body)
  (and (not (string= lang "python"))
       (not (string= lang "elisp"))
       (not (string= lang "dot"))))

(setq org-confirm-babel-evaluate #'my-org-confirm-babel-evaluate)

(setq org-id-link-to-org-use-id 't)
(org-id-update-id-locations (directory-files-recursively "./org/" "\\.org$"))
