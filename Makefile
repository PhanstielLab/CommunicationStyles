.PHONY: clean

objects :=\
	tables/longFormScores.txt\
	tables/selfScoreTable.txt\
	tables/groupScoreTable.txt\
	plots/selfScore.pdf\
	plots/groupScore.pdf\
	plots/groupToSelfScore.pdf

all: $(objects)

clean:
	rm -rf $(objects)

tables/longFormScores.txt\
tables/selfScoreTable.txt\
tables/groupScoreTable.txt:\
	scripts/processing/makeAssessmentTables.R
		mkdir -p tables
		Rscript scripts/processing/makeAssessmentTables.R

plots/selfScore.pdf\
plots/groupScore.pdf\
plots/groupToSelfScore.pdf:\
	tables/longFormScores.txt\
	scripts/analysis/visualizeCommunicationStyles.R
		mkdir -p plots
		Rscript scripts/analysis/visualizeCommunicationStyles.R