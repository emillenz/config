;;; Compiled snippets and support files for `json-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'json-mode
                     '(("eslint" "\"eslintConfig\": {\n    \"env\": {\n        \"es6\": true,\n        \"browser\": true,\n        \"commonjs\": true,\n        \"node\": true\n    },\n    \"parserOptions\": {\n        \"ecmaFeatures\": {\n            \"jsx\": true\n        }\n    }\n}" "eslintConfig"
                        (equal
                         (file-name-nondirectory buffer-file-name)
                         "package.json")
                        nil nil "/home/lenz/.config/doom/snippets/json-mode/eslintConfig" nil "eslint")))


;;; Do not edit! File generated at Tue Oct 31 17:43:58 2023
