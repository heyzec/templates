{
  python = {
    path = ./basic;
  };
  python-poetry = {
    path = ./poetry;
  };
  python-poetry2nix = {
    path = ./poetry2nix;
  };

  python-telegram-bot = {
    path = ./examples/python-telegram-bot;
    welcomeText = ''
      Run `python main.py` to see the bot in action!
      Remember to fill up populate .env first!
    '';
  };
}
