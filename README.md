# Tattletale: stop snitching.

Question: How do you **know** a cronjob finished?
Better yet, how do you know that ALL of your cronjobs finished? Most of the time, you just don't. Sure, cron sends some emails but most admins file those in the bitbucket. Most of the time we find out that a cronjob failed because whatever we were counting on it doing didn't happen.

![Tattletale screenshot](/doc/screenshots/tattletale.jpg?raw=true)

And thus at [Monitorama 2013](http://monitorama.com) hackathon, Tattletale was born. Register your job with Tattletale, call the unique URL Tattletale provides at the end of your job (if it completes successfully, of course), and Tattletale does the rest. Each job has a state, and each state (<tt>on_time</tt>, <tt>late</tt>, <tt>paused</tt>, and <tt>not_started</tt>) has its own visual appearance, making it easy to tell what's going on with a glance.

Here's a contrived example in Bash:
```bash
#!/bin/bash

cat<<EOM
Billy Quizboy: White! White, I'm being kidnapped by Zeus!
Pete White: That's what I've been telling you. That's why you should eat more fiber.
EOM

curl --silent --location http://tattletale.mydomain.local/masterbillyquizboy
exit 0
```

Tattletale is licensed under the MIT license, and it's a work in progress. It was written to scratch an itch, and as such it has some rough edges. Here's the pending To-Do list:

* Tests... because I sort of punted on those
* Output **reliable** job metadata in json
* Adapt [Bootstrap](http://twitter.github.com/bootstrap/) and clean up the custom (messy) CSS
* Adapt [Omniauth](https://github.com/intridea/omniauth) for pluggable authentication
* Retention plan for job check-ins (maybe [acts_as_trashable](https://github.com/bdurand/acts_as_trashable)?)
* Verify that generated job URLs are truly unique
* Spit & polish
