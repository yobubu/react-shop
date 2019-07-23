import React from "react";

const HomePage = () => (
  <div>
    <h1>Welcome to my board games shop</h1>

    <h2>More information about features implemented here coming soon!</h2>

    <p>
      You can create a new user and login to see the 'Add to cart' button
      (shopping cart not implemented yet). You can use credentials: login:
      admin@admin.com password: admin Then you will be able to create a new game
      and check form inputs validations. You can edit existed games or delete
      one of them as well. Don't worry about the database - I have a back-up :)
      I use here mongoDB. As an admin you can also switch 'Featured' option of
      game - just click on heart and observe sorting that takes first featured
      later alphabetical ascending rule. Click on the title of game to go to
      games details page. If price is below 30$ - there will be '!' next to
      price. There are still some bugs that are waiting in backlog to be picked
      up and repaired :) If you find some - will be great to get a feedback from
      you :)
    </p>
  </div>
);

export default HomePage;
