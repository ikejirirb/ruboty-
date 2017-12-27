require "spec_helper"

RSpec.describe Ruboty::Ehon do
  it "has a version number" do
    expect(Ruboty::Ehon::VERSION).not_to be nil
  end
end

describe Ruboty::Handlers::Ehon do
  let(:robot) do
    Ruboty::Robot.new
  end

  ehon = "わたしのワンピース"

  describe "ping" do
    it "replies to message \"ping\" and gives you \"pong\"" do
      expect(robot).to receive(:say).with(
        hash_including(body: "pong")
      )
      robot.receive(body: "#{robot.name} ping")
    end
  end

  describe "絵本追加" do
    it "replies to message \"絵本追加 #{ehon}\"" do
      expect(robot).to receive(:say).with(
        hash_including(body: "「#{ehon}」を追加したよ！")
      )
      robot.receive(body: "#{robot.name} 絵本追加 #{ehon}")
    end

    it "おなじタイトルの絵本は追加できない" do
      expect(robot).to receive(:say).with(
        hash_including(body: "「#{ehon}」を追加したよ！")
      )
      robot.receive(body: "#{robot.name} 絵本追加 #{ehon}")
      expect(robot).to receive(:say).with(
        hash_including(body: "「#{ehon}」はもうあるよ")
      )
      robot.receive(body: "#{robot.name} 絵本追加 #{ehon}")
    end
  end

  describe "絵本リスト" do
    it "絵本リストがないときはないって言う" do
      expect(robot).to receive(:say).with(
        hash_including(body: "絵本リストはまだないよ！追加してね！")
      )
      robot.receive(body: "#{robot.name} 絵本リスト")
    end

    it "絵本リストがあるときは愛想よく返事する" do
      expect(robot).to receive(:say).with(
        hash_including(body: "「#{ehon}」を追加したよ！")
      )
      robot.receive(body: "#{robot.name} 絵本追加 #{ehon}")
      expect(robot).to receive(:say).with(
        hash_including(body: ["わたしのワンピースは0回読みました。最後に読んだのは0日前です。"])
      )
      robot.receive(body: "#{robot.name} 絵本リスト")
    end
  end
end
