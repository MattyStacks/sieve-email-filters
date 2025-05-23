require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest"];
require ["fileinto", "imap4flags","vnd.proton.expire"];
/*
    * Filter is used to label steam sales emails. The steam sales emails are only good for about a week.
*/

# Set up variables
set "steam_sender" "noreply@steampowered.com";
set "steam_subject1" "Steam wishlist is now on sale";
set "steam_subject2" "Steam wishlist are now on sale";

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*", spamtest :value "ge" :comparator "i;ascii-numeric" "${1}") {
    return;
}

 # If it comes from steam, and says that the wishlist is on sale, then expire it in 7 days.
if allof (
    address :is "from" "${steam_sender}", 
    anyof (
        header :comparator "i;unicode-casemap" :contains "Subject" "${steam_subject1}",
        header :comparator "i;unicode-casemap" :contains "Subject" "${steam_subject2}"
    )
) {
    expire "day" "7";
    fileinto "expiring";
}

# Can't do two fileinto commands in one if statement, so we have to do it twice.
if allof (
    address :is "from" "${steam_sender}", 
    anyof (
        header :comparator "i;unicode-casemap" :contains "Subject" "${steam_subject1}",
        header :comparator "i;unicode-casemap" :contains "Subject" "${steam_subject2}"
    )
) {
    fileinto "promotions";
}