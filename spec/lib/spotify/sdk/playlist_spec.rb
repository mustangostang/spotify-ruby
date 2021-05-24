# frozen_string_literal: true

require "spec_helper"

RSpec.describe Spotify::SDK::Playlist do
  let(:session) { build(:session, access_token: "access_token") }
  subject { Spotify::SDK.new(session).me }

  describe "#info" do
    before(:each) do
      stub_spotify_api_request(fixture:  "get/v1/me/object",
                               method:   :get,
                               endpoint: "/v1/me")
      stub_spotify_api_request(fixture:  "get/v1/playlist/test",
                               method:   :get,
                               endpoint: "/v1/playlists/5USziwwemkHgck4zbMsvZU/tracks")
    end

    it "should return a Spotify::SDK::Me::Playlist object" do
      expect(subject.get_playlist('5USziwwemkHgck4zbMsvZU')).to be_kind_of( Spotify::SDK::Playlist)
    end

    it "should return the correct values" do
      tracks = subject.get_playlist('5USziwwemkHgck4zbMsvZU').get_tracks
      expect(tracks.size).to eq 100
      expect(tracks.map(&:to_h)).to eq read_fixture("get/v1/playlist/test")[:items]
    end
  end
end
