class InvitetoplaygameController < ApplicationController
    def new
        @game=params[:game]
        #@invitetoplaygame = Invitetoplaygame.new
    end
end
