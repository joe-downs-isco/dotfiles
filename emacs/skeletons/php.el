(define-skeleton php-dict-key
  "Helper skeleton for php-dict-skeleton"
  "Enter key: " "\"" str "\"")

(define-skeleton php-dict-value
  "Helper skeleton for php-dict-skeleton"
  "Enter value: " "\"" str "\"")

(define-skeleton php-dict-skeleton
  "Loops and prompts for input to populate associative array in PHP"
  "Foobar"
  ;;("Enter key: " "\"" str "\", " | "\""))
  ;;("Enter key: " "\""str"\"" & ("Enter value: " "\""str"\"")))
  ((php-dict-key) & "=>" (php-dict-value)))
