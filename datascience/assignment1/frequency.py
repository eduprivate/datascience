import sys
import json
import re

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

def print_frequency(tweet_file):
	tweets = load_tweets(tweet_file)
	parsed = parse_tweets(tweets)

	terms = {}
	for words in parsed:
		for w in words:
			terms[w] = terms[w]+1 if w in terms.keys() else 1

	freq_all = sum([v for (k,v) in terms.items()])
	freqs = map(lambda (k,v): { k: float(v)/freq_all }, terms.items())

	for d in freqs:
		print "%s %s" % (d.items()[0])

def main():
    tweet_file = open(sys.argv[1])

    print_frequency(tweet_file)

    tweet_file.close()

if __name__ == '__main__':
    main()