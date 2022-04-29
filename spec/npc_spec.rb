require_relative "../lib/Npc"
require_relative "npc_shared_examples"

RSpec.describe Npc do
  include_examples "npc basic attributes"
end