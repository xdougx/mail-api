module Kanamobi
  class Mailer
    attr_reader :imap, :email, :password
    
    def initialize(email, password)
      @email = email
      @password = password
    end

    def boxes
      transaction do
        imap.list('', '*')
      end
    end

    def get_emails(box)
      transaction do
        imap.select(box)
        uids = imap.search(["BEFORE", "05-Oct-2017", "SINCE", "09-Sep-2017"])
        uids.map { |id| fetch_2(id) }
      end
    end

    def fetch_1(uid)
      imap.uid_fetch(uid, ["ENVELOPE", "BODY","BODY[TEXT]"])
    end

    def fetch_2(uid)
      fetched = imap.uid_fetch(uid, ["ENVELOPE", "RFC822"])
      Mail.read_from_string(fetched.first.attr["RFC822"])
    end

    private
    
    def transaction(&block)
      connect
      login
      response = yield
      logout
      disconnect
      response
    end

    def connect
      @imap = Net::IMAP.new('box6540.bluehost.com', 993, true)
    end

    def login
      imap.login(email, password)
    end

    def logout
      imap.logout
    end

    def disconnect
      imap.disconnect
    end


  end
end