import time
import sys
import json
import re

class SentimentScore(object):
	_lookup = None

	def __init__(self, sent_file):
		if SentimentScore._lookup is None:
			SentimentScore._lookup = self._build_lookup(sent_file)

	def _build_lookup(self, sent_file):
		scores = {} 
		for line in sent_file:
		  term, score  = line.split("\t")  
		  scores[term] = int(score)  

		return scores

	def get_score(self, word):
		return self._lookup.get(word, 0)


def load_tweets(fp):
	lst = []

	line = fp.readline()
	while len(line) is not 0:
		data = json.loads(line.strip())
		lst.append(data)
		line = fp.readline()

	return lst

def parse_tweets(tweets):
	
	pattern = re.compile(r'\w+')
	parsed = []
	for t in tweets:
		if 'text' not in t.keys():
			continue

		words = pattern.findall(t['text'])
		parsed.append(words)

	return parsed

def print_sentiments(sent_file, tweet_file):
	tweets = load_tweets(tweet_file)
	scores = SentimentScore(sent_file)
	parsed = parse_tweets(tweets)

	sums = []
	
	for word_list in parsed:
		tweet_scores = [scores.get_score(w) for w in word_list]
		summed = sum(tweet_scores)
		sums.append(summed)

	print "tweet_count: %s" % len(tweets)
	print "sum: %s" % str(sum(sums))


def hw():
    print 'Hello, world!'

def lines(fp):
    print str(len(fp.readlines()))

def mount_scores():
    afinnfile = open("AFINN-111.txt")
    scores = {} 
    for line in afinnfile:
        term, score  = line.split("\t")  
        scores[term] = int(score)  
    print scores.items()         

def main():
    sent_file = open(sys.argv[1])
    tweet_file = open(sys.argv[2])
    hw()
    lines(sent_file)
    lines(tweet_file)
    mount_scores()
    print_sentiments(sent_file, tweet_file)

if __name__ == '__main__':
    main()
