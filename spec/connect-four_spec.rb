# frozen_string_literal: true
# spec/connect-four_spec.rb
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/main'

describe Game do
  describe '#choose_player_type' do
    subject(:game_players) { described_class.new() }
    let(:fake_player) { instance_double(Player) }
    context 'when user enters in Human' do
      it 'returns human' do
        allow(game_players).to receive(:puts)
        allow(game_players).to receive(:gets).and_return('Human')
        type = game_players.choose_player_type(fake_player)
        expect(type).to eq('human')
      end
    end

    context 'when user enters in Computer' do
      it 'returns computer' do
        allow(game_players).to receive(:puts)
        allow(game_players).to receive(:gets).and_return('Computer')
        type = game_players.choose_player_type(fake_player)
        expect(type).to eq('computer')
      end
    end

    context 'when user enters in something else, then human' do
      before do
        allow(game_players).to receive(:puts).once
        allow(game_players).to receive(:gets).and_return('tramalfadorian')
      end

      it 'runs twice and returns human' do
        allow(game_players).to receive(:puts).once
        allow(game_players).to receive(:gets).and_return('human')
        type = game_players.choose_player_type(fake_player)
        expect(type).to eq('human')
      end
    end
  end

  describe '#create_player' do
    subject(:game_create) { described_class.new() }
    context 'when an example human is created' do
      it 'creates a human player named bob with symbol X' do
        allow(game_create).to receive(:choose_player_type).and_return('human')
        player = game_create.create_player('bob', 'X')
        expect(player.class).to be(Human)
      end
    end

    context 'when an example computer player is created' do
      it 'creates a computer player named geraldo with symbol O' do
        allow(game_create).to receive(:choose_player_type).and_return('computer')
        player = game_create.create_player('geraldo', 'O')
        expect(player.class).to be(Computer)
      end
    end
  end

  describe '#play_game' do
    # Need to test that loop ends correctly

  end

  describe '#change_active' do
    subject(:game_active) { described_class.new() }
    before do
      game_active.instance_variable_set(:@player1, 'bobby')
      game_active.instance_variable_set(:@player2, 'sarah')
    end

    context 'when there is no active player' do
      it 'sets the active player as player 1' do
        expect {game_active.change_active}.to change { game_active.active_player}.to('bobby')
      end
    end

    context 'when Player 1 is the active player' do
      before do
        game_active.instance_variable_set(:@active_player, 'bobby')
      end
      it 'sets Player 2 as active' do
        expect {game_active.change_active}.to change { game_active.active_player}.to('sarah')
      end
    end

    context 'when Player 2 is the active player' do
      before do
        game_active.instance_variable_set(:@active_player, 'sarah')
      end
      it 'sets Player 1 as active' do
        expect {game_active.change_active}.to change { game_active.active_player}.to('bobby')
      end
    end
  end

  describe '#four_horizontal?' do
    context 'when board has four in a row' do
      subject(:horizontal_end) { described_class.new() }
      before do
        horizontal_end.board.grid[5] = [nil, nil, 'O', 'O', 'O', 'O', nil] 
      end
      it 'returns true' do
        expect(horizontal_end.four_horizontal?).to be true
      end
    end

    context 'when board does not have four in a row' do
      subject(:horizontal_mid) { described_class.new() }
      it 'returns false' do
        expect(horizontal_mid.four_horizontal?).to be false
      end
    end
  end

  describe '#four_vertical?' do
    context 'when board has four in a row' do
      subject(:vertical_end) { described_class.new() }
      before do
        vertical_end.board.grid[1][2] = 'X'
        vertical_end.board.grid[2][2] = 'X'
        vertical_end.board.grid[3][2] = 'X'
        vertical_end.board.grid[4][2] = 'X'
      end
      it 'returns true' do
        expect(vertical_end.four_vertical?).to be true
      end
    end

    context 'when board does not have four in a row' do
      subject(:vertical_mid) { described_class.new() }
      it 'returns false' do
        expect(vertical_mid.four_vertical?).to be false
      end
    end
  end

  describe '#four_diagonal?' do
    subject(:diagonal_end) { described_class.new() }
    before do
      diagonal_end.board.grid[1][2] = 'X'
      diagonal_end.board.grid[2][3] = 'X'
      diagonal_end.board.grid[3][4] = 'X'
      diagonal_end.board.grid[4][5] = 'X'
    end
    it 'returns true' do
      expect(diagonal_end.four_diagonal?).to be true
    end
  end

  context 'when board does not have four in a row' do
    subject(:diagonal_mid) { described_class.new() }
    it 'returns false' do
      expect(diagonal_mid.four_diagonal?).to be false
    end
  end

  describe '#player_move' do
    context 'when the player is human' do
      subject(:game_human) { described_class.new() }
      let(:fake_board) { instance_double(Board) }
      let(:fake_human) { instance_double(Human) }
      context 'when the player enters in an invalid column, then a valid column' do
        before do
          game_human.instance_variable_set(:@board, fake_board)
          game_human.instance_variable_set(:@active_player, fake_human)
          allow(fake_board).to receive(:valid_move?).and_return(false, true)
          allow(fake_human).to receive(:move).and_return(24,2)
        end
        it 'outputs error message, then accepts second entry' do
          move = game_human.player_move(fake_human)
          expect(move).to eq(2)
        end
      end

      context 'when the player enters in a valid column' do
        
      end
    end

    context 'when the player is a computer' do
      subject(:game_computer) { described_class.new() }
      context 'when the player enters in an invalid column' do
        
      end

      context 'when the player enters in a valid column' do
        
      end
    end
  end

  describe '#game_over?' do
    # Don't need to test since just a script
  end

  describe '#end_game' do
    context 'when the game has ended' do
      subject(:game_end) { described_class.new()}
      let(:fake_player) { instance_double(Player, name: 'Gerald')}
      before do
        game_end.instance_variable_set(:@round, 4)
        game_end.instance_variable_set(:@active_player, fake_player)
      end
      it 'returns the string with the correct players name and rounds' do
        expect(game_end).to receive(:puts).with('Good game. Gerald won the game in 4 rounds.')
        game_end.end_game
      end
    end
  end
end

describe Human do
  describe '#move' do
    subject(:human_move) { described_class.new('Player 2', 'X')}

    context 'when human provides integer' do
      it 'returns the integer' do
        allow(human_move).to receive(:puts)
        allow(human_move).to receive(:gets).and_return('6')
        move = human_move.move
        expect(move).to be(6)
      end
    end
  end
end

describe Computer do
  describe '#move' do
    subject(:computer_move) { described_class.new("Player 1", 'O')}
    context 'when number of columns is given' do
      it 'returns a number inside the columns' do
        column = computer_move.move(2)
        expect(column).to be_between(0,2)
      end
    end

    context 'when number of columns is not given' do
      it 'returns a number between 1 and 7' do
        column = computer_move.move
        expect(column).to be_between(1,7)
      end
    end
  end
end

describe Board do
  describe '#update_board' do
    context 'when board is empty' do
      subject(:board_empty) { described_class.new(6,7)}
      let(:fake_player) { instance_double(Player, symbol: "X") }
      it 'adds in the move to the bottom row of the board' do
        column = 6
        board_empty.update_board(column, fake_player)
        expect(board_empty.grid[0]).to eq([nil, nil, nil, nil, nil, 'X', nil])
      end
    end

    context 'when there are some pieces already in the board' do
      subject(:board_mid) { described_class.new(6, 7)}
      let(:fake_player) { instance_double(Player, symbol: "X") }
      it 'adds in the move to the old board' do
        board_mid.grid[0][3] = 'O'
        board_mid.grid[0][4] = 'O'
        board_mid.grid[0][5] = 'X'
        board_mid.grid[1][3] = 'X'
        board_mid.grid[1][4] = 'X'
        board_mid.grid[2][3] = 'X'
        column = 4
        board_mid.update_board(column, fake_player)
        expect(board_mid.grid).to eq([[nil, nil, nil, 'O', 'O', 'X', nil],
                                     [nil, nil, nil, 'X', 'X', nil, nil],
                                     [nil, nil, nil, 'X', nil, nil, nil],
                                     [nil, nil, nil, 'X', nil, nil, nil],
                                     [nil, nil, nil, nil, nil, nil, nil],
                                     [nil, nil, nil, nil, nil, nil, nil]])
      end
    end
  end

  describe '#valid_move?' do
    subject(:board_valid) { described_class.new() }
    context 'when the move is valid' do
      it 'returns true' do
        validity = board_valid.valid_move?(6)
        expect(validity).to be true
      end
    end

    subject(:board_off) { described_class.new() }
    context 'when the move is off the board' do
      it 'returns false' do
        validity = board_off.valid_move?(8)
        expect(validity).to be false
      end
    end

    subject(:board_full) { described_class.new() }
    context 'when the move is in a full column' do
      it 'returns false' do
        board_full.grid =[[nil, nil, nil, 'O', nil, nil, nil],
                         [nil, nil, nil, 'O', nil, nil, nil],
                         [nil, nil, nil, 'X', nil, nil, nil],
                         [nil, nil, nil, 'X', nil, nil, nil],
                         [nil, nil, nil, 'X', 'X', nil, nil],
                         [nil, nil, nil, 'O', 'O', 'X', nil]]
        validity = board_full.valid_move?(4)
        expect(validity).to be false
      end
    end
  end

  describe '#display_board' do
    # Shouldn't need to test since uses print but maybe test that calls print
    # the right number of times? 1 per square plus 1 per row
  end

end