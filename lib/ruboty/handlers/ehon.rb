module Ruboty
  module Handlers
    class Ehon < Base
      NAMESPACE = "ehon"

      on(/絵本追加 (?<title>.+)/i, name: "add_ehon", description: "絵本を追加する")
      on(/絵本リスト/i, name: "show_ehon", description: "絵本リストを見る")
      on(/(?<title>.+) 読んだ/i, name: "read_ehon", description: "読んだ絵本を記録する")

      def add_ehon(message)
        title = message[:title]
        created_at = Time.now.getlocal("+09:00")
        updated_at = created_at

        if ehons.empty?
          ehons << {title: title, created_at: created_at, updated_at: updated_at, count: 0}
          message.reply("「#{title}」を追加したよ！")
        else
          if ehons.find {|ehon| ehon.has_value?(title) }
            message.reply("「#{title}」はもうあるよ")
          else
            ehons << {title: title, created_at: created_at, updated_at: updated_at, count: 0}
            message.reply("「#{title}」を追加したよ！")
          end
        end
      end

      def show_ehon(message)
        message.reply(ehons)
      end

      def read_ehon(message)
        title = message[:title]
        updated_at = Time.now.getlocal("+09:00")

        if ehon = ehons.find {|ehon| ehon.has_value?(title) }
          ehon.update(updated_at: updated_at)
          ehon.update(count: ehon[:count] += 1)
          message.reply("#{title}を#{ehon[:count]}回読んだよ")
        else
          message.reply("「#{title}」はリストにないからまず追加してね")
        end
      end

      private

      def ehons
        data[:ehons] ||= []
      end

      def data
        robot.brain.data[NAMESPACE] ||= {}
      end
    end
  end
end
