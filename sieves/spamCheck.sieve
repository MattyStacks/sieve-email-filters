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

# Check to see if the email is from the allow list
if  anyof (
    header :list "From" ":incomingdefaults:inbox"
) {
    stop;
}

/**
 * @type or
 * @comparator contains
 * @comparator contains
 */
# Check for common spam patterns in the sender's subject
if anyof (header :comparator "i;unicode-casemap" :contains "Subject" "penis", 
        header :comparator "i;unicode-casemap" :contains "Subject" "cialis") {
    fileinto "spamCheck";
}