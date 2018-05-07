require 'telegram/bot'

class Bot::BotServer
  def self.run_bot_server(rails_logger=nil)
    token = ENV['TELEGRAM_TOKEN']
    Telegram::Bot::Client.run(token, logger: rails_logger) do |bot|
      bot.listen do |message|
        case message
        when Telegram::Bot::Types::CallbackQuery
          if message.data == 'best'
            bot.api.send_message(parse_mode: 'Markdown', chat_id: message.from.id, text: best_workout)
          end
          if message.data == 'yes'
            bot.api.send_message(parse_mode: 'Markdown', chat_id: message.from.id, text: my_workout(@email))
          end
          if message.data == 'no'
            bot.api.send_message(parse_mode: 'Markdown', chat_id: message.from.id, text: "Ok let's insert again")
          end
        else
          case message.text
          when %r(^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$)
            kb = [
              Telegram::Bot::Types::InlineKeyboardButton.new(text: 'No let me insert again', callback_data: 'no'),
              Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Sure', callback_data: 'yes')
            ]
            @email = message.text
            markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
            bot.api.send_message(chat_id: message.chat.id, text: "Is that your email?", reply_markup: markup)
          when '/createworkout'
            bot.api.send_message(chat_id: message.chat.id, text: "Sorry this command is yet to be implemented")
          when '/myworkout'
            bot.api.send_message(chat_id: message.chat.id, text: "Please enter your email")
          when '/help'
            bot.api.send_message(chat_id: message.chat.id, text: "I am here to help you. Type /workout, /myworkout or /createworkout")
          when '/hello'
            bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
          when '/bye'
            bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
          when '/workout'
            kb = [
              Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Go to app', url: 'https://google.com'),
              Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Get me one workout', callback_data: 'best'),
              Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Share this app', switch_inline_query: 'Hey have you heard about Gymshare. It\'s awesome dude')
            ]
            markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
            bot.api.send_message(chat_id: message.chat.id, text: 'Make a choice', reply_markup: markup)
          else
            bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}. Please type /help for list of command")
          end
        end
      end
    end
  end

  private

  def self.best_workout
    workout_plan = ::WorkoutPlan.first
    return "No workout plan in database" if workout_plan.empty?
    result = "*I got the best workout for you. Let's start*"
    rounds = ::Round.where(workout_plan_id: workout_plan.id)
    rounds.each_with_index do |round, round_index|
      result << "\nRound _#{round_index}_ : "
      round.exercises.each_with_index do |exercise, index|
        result << "\nExercise _#{index}_ :"\
          "\n  *#{exercise.name}* - #{exercise.description}"\
          "\n  Weight: #{exercise.weight} kilogram and Reps: #{exercise.reps}"
        if index != round.exercises.length - 1 && round.rests[index] != nil
          result << "\n  Then rest for #{round.rests[index].rest_time} minutes"
        end
      end
    end
    result
  end

  def self.my_workout(email)
    user = ::User.where(email: email)
    return "No user found with that email" if user.empty?

    offset = rand(::WorkoutPlan.where(user: user).count)
    workout_plan = ::WorkoutPlan.where(user: user).offset(offset).first
    return "No workout plan in database" if workout_plan.empty?

    result = "*I got the best workout for you. Let's start*"
    rounds = ::Round.where(workout_plan_id: workout_plan.id)
    rounds.each_with_index do |round, round_index|
      result << "\nRound _#{round_index}_ : "
      round.exercises.each_with_index do |exercise, index|
        result << "\nExercise _#{index}_ :"\
          "\n  *#{exercise.name}* - #{exercise.description}"\
          "\n  Weight: #{exercise.weight} kilogram and Reps: #{exercise.reps}"
        if index != round.exercises.length - 1 && round.rests[index] != nil
          result << "\n  Then rest for #{round.rests[index].rest_time} minutes"
        end
      end
    end
    result
  end
end