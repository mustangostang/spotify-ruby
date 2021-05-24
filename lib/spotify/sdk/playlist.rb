# frozen_string_literal: true

module Spotify
  class SDK
    class Playlist < Model

      def get_tracks(limit=100, override_opts={})
        request = {
          method:    :get,
          # TODO: Spotify API bug - `limit={n}` returns n-1 artists.
          # ^ Example: `limit=5` returns 4 artists.
          http_path: "/v1/playlists/#{playlist_id}/tracks",
          keys:      %i[items],
          limit:     limit
        }

        parent.send_multiple_http_requests(request, override_opts).map do |track|
          Spotify::SDK::Track.new(track, parent)
        end
      end

    end
  end
end