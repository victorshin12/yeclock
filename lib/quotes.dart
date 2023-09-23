import 'dart:math';

List<String> quotes = [
  "Believe in your flyness…conquer your shyness",
  "Would you believe in what you believe in if you were the only one who believed it?",
  "Everyone’s always telling you to be humble. When was the last time someone told you to be great?",
  "Life is 5% what happens, and 95% how you react",
  "Even a broke clock is right twice a day",
  "This is my life homie, you decide yours",
  "Everything I’m not makes me everything I am",
  "I refuse to follow the rules where society tries to control people with low self-esteem",
  "I don’t expect to be understood at all.",
  "I’m on the pursuit of awesomeness, excellence is the bare minimum",
  "Bravery and courage is walking into pain and knowing that something better is on the other side",
  "You can’t look at a glass half full or empty if it’s overflowing",
  "I refuse to accept other people’s ideas of happiness for me. As if there’s a ‘one size fits all’ standard for happiness",
  "Nothing in life is promised except death",
  "Recognize and embrace your flaws so you can learn from them. Sometimes it takes a little polishing to truly shine",
  "Success is the best revenge",
  "If you’re taught you can’t do anything you won’t do anything, I was taught I could do everything",
  "Memories have to be our most painful blessing",
  "For me giving up is way harder than trying",
  "Criticism can bother you, but you should be more bothered if there’s no criticism. That means you’re too safe",
  "You’re not perfect, but you’re not your mistakes",
  "Shoot for the stars, so if you fall you land on a cloud",
  "Living well eliminates the need for revenge",
  "The prettiest people do the ugliest things",
  "I’m not comfortable with comfort. I’m only comfortable when I’m in a place where I’m constantly learning and growing",
  "You may be talented but you’re not Kanye West",
  "If you have the opportunity to play this game of life you need to appreciate every moment.",
  "They say your attitude determines your latitude",
  "They say people in your life are seasons and anything that happens is for a reason",
  "I would say my determination is way higher than my smartness",
  "Being fresh is more important than having money",
  "I know I got angels watchin me from the other side",
  "God show me the way because the Devil trying to break me down",
  "It’s about whatever I want to make it about. It’s my world",
  "If you know you’re the best it only makes sense for you to surround yourself with the best",
];

String getQuote() {
  int randIndex = Random().nextInt(quotes.length);
  return quotes[randIndex];
  
}