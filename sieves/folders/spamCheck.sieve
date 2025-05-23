require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest"];
require ["fileinto", "imap4flags", "regex", "extlists"];

/*
    * This script is designed to aggressively filter spam emails into a "spamCheck" folder.
    * It checks for common spam patterns in the sender's display name, body content, and other characteristics.
    * As spam gets more complex this will be fine tuned to catch more spam.
*/

# Generated: Do not run this script on messages already marked as spam.
if allof (environment :matches "vnd.proton.spam-threshold" "*", spamtest :value "ge" :comparator "i;ascii-numeric" "${1}") {
    return;
}

# Check ProtonMail's Allow List first - if sender is on allow list, skip spam checking
if address :list "From" ":incomingdefaults:inbox" {
    stop;
}

# Also check personal contacts - if sender is in personal contacts, skip spam checking
if address :list "From" "addrbook:personal" {
    stop;
}

# Check sender display names for suspicious patterns
if anyof (
    header :regex "From" "(?i)(customer.?service|security.?team|account.?department)",
    header :regex "From" "(?i)(billing.?department|support.?team|verification.?team)",
    header :regex "From" "(?i)(admin|webmaster|postmaster).*[0-9]{3,}",
    header :regex "From" "(?i)(paypal|amazon|apple|microsoft|google).*(security|support|team)",
    header :contains "From" ["CEO", "Manager", "Director", "President"]  # Generic titles
) {
    fileinto "spamCheck";
    stop;
}

# Check subject lines for spam patterns
if anyof (
    header :regex "Subject" "(?i)(viagra|cialis|penis|enlargement|weight.?loss)",
    header :regex "Subject" "(?i)(get.?rich|make.?money|work.?from.?home)",
    header :regex "Subject" "(?i)(lottery|winner|inheritance|congratulations)",
    header :regex "Subject" "(?i)(urgent.?response|act.?now|limited.?time)",
    header :regex "Subject" "(?i)(casino|poker|gambling|bet.?now)"
) {
    fileinto "spamCheck";
    stop;
}

# Check for emails with no proper sender name (just email address)
if address :regex "From" "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$" {
    fileinto "spamCheck";
    stop;
}

# Check for suspicious Reply-To addresses different from sender
if anyof (
    allof (
        exists "Reply-To",
        not address :comparator "i;unicode-casemap" "From" "Reply-To"
    )
) {
    fileinto "spamCheck";
    stop;
}

