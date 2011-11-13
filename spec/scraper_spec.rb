require "spec_helper"

describe BGG::Scraper do
  subject { BGG::Scraper }

  after do
    VCR.eject_cassette
  end

  describe "breaking a total into pages and remainder" do
    data = { 1    => [ 1,  1 ],
             50   => [ 1,  50 ],
             100  => [ 1,  0 ],
             101  => [ 2,  1 ],
             199  => [ 2,  99 ],
             200  => [ 2,  0 ],
             201  => [ 3,  1 ],
             999  => [ 10, 99 ],
             1000 => [ 10, 0 ],
             1001 => [ 11, 1 ] }

    data.each do |total, desired_results|
      pages, remainder = desired_results

      it "breaks a total of #{total} into #{pages} pages and #{remainder} remainder" do
        final_pages, final_remainder = subject.break_down_total(total)
        final_pages.must_be :==, pages
        final_remainder.must_be :==, remainder
      end
    end
  end

  describe "a game record" do
    before do
      VCR.insert_cassette('board_game_geek_1')
    end

    let(:first_game) { subject.top_games(1).first }

    it "exposes some handy attributes" do
      first_game.must_respond_to :name
      first_game.must_respond_to :image_url
      first_game.must_respond_to :rating
      first_game.must_respond_to :ranking
      first_game.must_respond_to :release_date
    end

    it "correctly parses the image source" do
      first_game.image_url.must_be :==, "http://cf.geekdo-images.com/images/pic361592_t.jpg"
    end
  end

  it "gets the top 100 games" do
    VCR.insert_cassette('board_game_geek_100')
    subject.top_games(100).length.must_be :==, 100
  end

  it "gets the top 1000 games" do
    VCR.insert_cassette('board_game_geek_1000')
    subject.top_games(1000).length.must_be :==, 1000
  end
end