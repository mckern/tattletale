# Tattletale: stop snitching.

Question: How do you **know** a cronjob finished?
Better yet, how do you know that ALL of your cronjobs finished? Most of the time, you just don't. Sure, cron sends some emails but most admins file those in the bitbucket. Most of the time we find out that a cronjob failed because whatever we were counting on it doing didn't happen.

![Tattletale screenshot](/doc/screenshots/tattletale.jpg?raw=true)

And thus at [Monitorama 2013](http://monitorama.com) hackathon, Tattletale was born. Register your job with Tattletale, call the unique URL Tattletale provides at the end of your job (if it completes successfully, of course), and Tattletale does the rest.

Here's a contrived example in Bash:
```bash
#!/bin/bash

cat<<EOM
Billy Quizboy: White! White, I'm being kidnapped by Zeus!
Pete White: That's what I've been telling you. That's why you should eat more fiber.
EOM

curl -L http://tattletale.mydomain.local/masterbillyquizboy
exit 0
```

Tattletale is licensed under the MIT license, and it's a work in progress. It was written to scratch an itch, and as such it has some rough edges. Here's the pending To-Do list:

* Tests... because I sort of punted on those
* Output Service metadata in json
* Adapt Omniauth for pluggable authentication
* Retention plan for service check-ins
* Spit & polish
