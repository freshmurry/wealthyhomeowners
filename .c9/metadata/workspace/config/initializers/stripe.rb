{"filter":false,"title":"stripe.rb","tooltip":"/config/initializers/stripe.rb","undoManager":{"mark":5,"position":5,"stack":[[{"start":{"row":0,"column":0},"end":{"row":5,"column":0},"action":"insert","lines":["Rails.configuration.stripe = {","  :publishable_key => 'YOUR_STRIPE_PUBLISHABLE_KEY',","  :secret_key => 'YOUR_STRIPE_SECRET_KEY'","}","Stripe.api_key = Rails.configuration.stripe[:secret_key]",""],"id":1}],[{"start":{"row":4,"column":56},"end":{"row":5,"column":0},"action":"remove","lines":["",""],"id":2}],[{"start":{"row":1,"column":23},"end":{"row":1,"column":50},"action":"remove","lines":["YOUR_STRIPE_PUBLISHABLE_KEY"],"id":3},{"start":{"row":1,"column":23},"end":{"row":1,"column":55},"action":"insert","lines":["pk_live_Xm7AAr63QCQDP4fvvZ6P9DbT"]}],[{"start":{"row":2,"column":18},"end":{"row":2,"column":40},"action":"remove","lines":["YOUR_STRIPE_SECRET_KEY"],"id":4},{"start":{"row":2,"column":18},"end":{"row":2,"column":50},"action":"insert","lines":["sk_live_BSFqw4FNkn8O6tfW3OPfgmRY"]}],[{"start":{"row":1,"column":23},"end":{"row":1,"column":55},"action":"remove","lines":["pk_live_Xm7AAr63QCQDP4fvvZ6P9DbT"],"id":5},{"start":{"row":1,"column":23},"end":{"row":1,"column":55},"action":"insert","lines":["pk_test_hh96iSsb8UnLNrA9S1aNYNTQ"]}],[{"start":{"row":2,"column":18},"end":{"row":2,"column":50},"action":"remove","lines":["sk_live_BSFqw4FNkn8O6tfW3OPfgmRY"],"id":6},{"start":{"row":2,"column":18},"end":{"row":2,"column":50},"action":"insert","lines":["sk_test_25ExbWKt6MIfjnJkgUSVHI6P"]}]]},"ace":{"folds":[],"scrolltop":0,"scrollleft":0,"selection":{"start":{"row":4,"column":56},"end":{"row":4,"column":56},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":0},"timestamp":1507781550187,"hash":"23ea41500808fb644028658dd8b56123745027c4"}