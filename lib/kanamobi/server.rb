module Kanamobi
  class Server < Grape::API
    format :json
    
    helpers do
      def client
        @client ||= Kanamobi::Mailer.new('douglas@kanamobi.com.br', 'dnkroz3361!D')
      end

      def logger
        @logger = Logger.new(STDOUT)
      end

      def luls
        logger.info params
      end
    end

    get '/:a/:b' do
      luls
      {message: 'Damn youre ugly!'}
    end

    get :emails do
      client.get_emails("INBOX.[Kanamobi]").map do |email|
        {from: email.from, to: email.to, subject: email.subject }
      end
    end

  end
end