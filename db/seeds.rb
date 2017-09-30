# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(name: 'Malcolm Gladwell', email: 'user@user.com', password: 'password', password_confirmation: 'password')

articles = [
    {
        title: 'Blink: The Power of Thinking Without Thinking',
        content: "Blink: The Power of Thinking Without Thinking (2005) is Malcolm Gladwell's second book. It presents in popular science format research from psychology and behavioral economics on the adaptive unconscious: mental processes that work rapidly and automatically from relatively little information. It considers both the strengths of the adaptive unconscious, for example in expert judgment, and its pitfalls, such as stereotypes.",
        user_id: user.id,
        tags: {
            0 => {
                name: 'Non-fiction',
                sub_tags: ['brain-power', 'thin-slicing']
            },
            1 => {
                name: 'Self-help',
                sub_tags: ['science']
            }
        }
    },
    {
        title: 'The Tipping Point',
        content: "The Tipping Point: How Little Things Can Make a Big Difference is the debut book by Malcolm Gladwell, first published by Little Brown in 2000. Gladwell defines a tipping point as 'the moment of critical mass, the threshold, the boiling point'.",
        user_id: user.id
    },
    {
        title: 'Outliers',
        content: "Outliers: The Story of Success is the third non-fiction book written by Malcolm Gladwell and published by Little, Brown and Company on November 18, 2008. In Outliers, Gladwell examines the factors that contribute to high levels of success.",
        user_id: user.id,
        tags: {
            1 => {
                name: 'Psychology',
                sub_tags: ['science']
            }
        }
    },
    {
        title: 'What the Dog Saw',
        content: "What the Dog Saw is a compilation of 19 articles by Malcolm Gladwell that were originally published in The New Yorker which are categorized into three parts. The first part, Obsessives, Pioneers, and other varieties of Minor Genius, describes people who are very good at what they do, but are not necessarily well-known. Part two, Theories, Predictions, and Diagnoses, describes the problems of prediction.",
        user_id: user.id,
        tags: {
            0 => {
                name: 'Psychology',
                sub_tags: ['science', 'brain']
            },
            1 => {
                name: 'Non-fiction'
            },
            2 => {
                name: 'Self-help'
            }
        }
    }
]

articles.each {|article_params| Article.save_article(article_params) }
