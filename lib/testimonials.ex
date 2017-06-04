defmodule Testimonials do
  def phoenix do
    [%{
      image_url: "https://s3.amazonaws.com/phoenix-tutorial/franco_barbeite.jpg",
      text: "<p>\"The explanations are crystal clear. The exercises, while simple, do a good job of covering corner cases that might otherwise not be obvious.\"</p>
            <p>-- Franco Barbeite, Senior Software Engineer at LiftForward</p>"
    }, %{
      image_url: "	https://s3.amazonaws.com/phoenix-tutorial/giuseppe-pic.jpg",
      text: "<p>\"Very well written, straight to the point, and with a clean, clear, style.\"</p>
      <p>Giuseppe Caruso, Front End Developer, UI/UX Architect</p>"
    }]
  end

  def ember do
    [
      %{
        image_url: "https://s3.amazonaws.com/ember-school/jonathanjackson.jpeg",
        text: "<p>\"It’s amazing.  It’s really wonderful.  The structure of it is super great, and I’ve been really blown away by the quality of the content.\"</p>
          <p>--Jonathan Jackson, Hashrocket dev, Co-host of EmberWeekend</p>"
      }, %{
        image_url: "https://s3.amazonaws.com/ember-school/KarlArao.JPG",
        text: "<p>\"I'm loving it. Your videos make it easy to learn ember... way better than my ember 1.0 experience.\"</p>
          <p>--Karl Arao, EmberSchool Student</p>"
      }, %{
        image_url: "https://s3.amazonaws.com/ember-school/stevekinney.jpeg",
        text: "<p>\"If you’re interested in learning @emberjs, @JeffreyBiles’s EmberSchool is pretty amazing.\"</p>
          <p>--Steve Kinney, Director of Frontend Engineering Program at Turing School</p>"
      }, %{
        image_url: "https://s3.amazonaws.com/ember-school/Grant1.jpg",
        text: "<p>\"It’s very good, and it’s the first time that I have felt comfortable spending this amount of money for training.\"</p>
          <p>--Grant Neale, EmberSchool Student</p>"
      }, %{
        image_url: "https://s3.amazonaws.com/ember-school/carengarcia.jpg",
        text: "<p>\"Learning #ember? I highly recommend @JeffreyBiles Ember School.  It's thorough, well explained and legit af.\"</p>
          <p>--Caren Garcia, One More Cloud dev, TA for University of Texas' Coding Class</p>"
      }, %{
        image_url: "https://s3.amazonaws.com/ember-school/alex.jpg",
        text: "<p>\"The course has been great at making Ember feel much more approachable; I think this is in part due to your focus on getting apps set up quickly and seeing 'real results' during the first course.\"</p>
          <p>--Alex, EmberSchool Student</p>"
      }, %{
        image_url: "https://s3.amazonaws.com/ember-school/davidtangpic.jpeg",
        text: "<p>\"Just tried Ember School by @JeffreyBiles and it's AWESOME! Really high quality content and experience.\"</p>
          <p>--David Tang, thejsguy.com, CareerJS panelist</p>"
      }, %{
        image_url: "https://s3.amazonaws.com/ember-school/aaronlarnerlargerpic.jpeg",
        text: "<p>\"For all you JS devs out there that are interested in Ember, I highly recommend this resource. Very well thought out and clear content!\"</p>
          <p>--Aaron Larner, Trello dev, former Iron Yard instructor</p>"
      }
    ]
  end
end
