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

  describe "ping" do
    it "replies to message \"ping\" and gives you \"pong\"" do
      expect(robot).to receive(:say).with(
        hash_including(body: "pong")
      )
      robot.receive(body: "#{robot.name} ping")
    end
  end
end