require 'telegram/bot'

class Bot::BotServer
  def self.run_bot_server(rails_logger=nil)
    token = ENV['TELEGRAM_TOKEN']
    Telegram::Bot::Client.run(token, logger: rails_logger) do |bot|
      bot.listen do |message|
        case message
        when Telegram::Bot::Types::CallbackQuery
          bot.logger.warn "I came callback"
          if message.data == 'best'
            bot.logger.warn "I came"
            bot.api.send_message(parse_mode: 'Markdown', chat_id: message.from.id, text: best_workout)
          end
        else
          case message.text
          when '/createworkout'
            bot.api.send_message(chat_id: message.chat.id, text: "Sorry this command is yet to be implemented")
          when '/myworkout'
            bot.api.send_message(chat_id: message.chat.id, text: "Sorry this command is yet to be implemented")
          when '/help'
            bot.api.send_message(chat_id: message.chat.id, text: "I am here to help you. Type /workout, /myworkout or /createworkout")
          when '/hello'
            bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
          when '/bye'
            bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
          when '/workout'
            bot.logger.warn "I came workout"
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
    return "No workout plan in database" if !workout_plan
    result = "*I got the best workout for you. Let's start*"
    rounds = ::Round.where(workout_plan_id: workout_plan.id)
    rounds.each_with_index do |round, round_index|
      result << "\nRound _#{round_index}_ : "
      round.exercises.each_with_index do |exercise, index|
        result << "\nExercise _#{index}_ :"\
          "\n  _#{exercise.name}_ - #{exercise.description}"\
          "\n  Weight: #{exercise.weight} and Reps: #{exercise.reps}"
        if index != round.exercises.length - 1 && round.rests[index] != nil
          result << "\n  Then rest for #{round.rests[index].rest_time}"
        end
      end
    end
    result
  end
end