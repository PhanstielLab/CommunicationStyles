## Load required packages
library(tidyverse)
library(ggplot2)
library(geomtextpath)

## Read in long format data
scores <- read_delim(file="tables/longFormScores.txt", delim="\t")

## Normalize scores to percentage
scores <-
  scores |>
  group_by(person) |>
  mutate(selfScore = selfScore/sum(selfScore) * 100,
         groupScore = groupScore/sum(groupScore) * 100)

## Get "doer/connector" and "thinker/influencer" score for self and group
scoresSelf <-
  scores |>
  pivot_wider(id_cols=c(person, yearsInLab), names_from=category, values_from=selfScore) |>
  mutate(relationshipTaskSelf=(Connector+Influencer)-(Thinker+Doer),
         askTellSelf=(Connector+Thinker)-(Doer+Influencer))

scoresGroup <- 
  scores |>
  pivot_wider(id_cols=c(person, yearsInLab), names_from=category, values_from=groupScore) |>
  mutate(relationshipTaskGroup=(Connector+Influencer)-(Thinker+Doer),
         askTellGroup=(Connector+Thinker)-(Doer+Influencer))

## Combine & select relevant columns
combined <- 
  left_join(x=scoresSelf, y=scoresGroup, by="person") |>
  select(ends_with(c("person", "yearsInLab.x", "Self", "Group")))

colnames(combined)[2] <- "yearsInLab"


## Visualize self score
ggplot(data=combined, aes(x=askTellSelf, y=relationshipTaskSelf)) +
  ylim(c(-100, 100)) +
  xlim(c(-100, 100)) +
  geom_hline(yintercept=0, lty=3, color="grey50") +
  geom_vline(xintercept=0, lty=3, color="grey50") + 
  geom_text(aes(label=person)) +
  annotate(geom='label',
           size=5,
           color="grey50",
           label.size=NA,
           x=c(0, 0, -100, 100),
           y=c(-100, 100, 0, 0),
           label=c("TASK", "RELATIONSHIP", "TELL", "ASK")) +
  annotate(geom='text',
           size=5,
           color="grey50",
           label.size=NA,
           x=c(-80, -80, 80, 80),
           y=c(-80, 80, 80, -80),
           label=c("DOER", "INFLUENCER", "CONNECTOR", "THINKER")) +
  theme_bw() +
  theme(panel.grid=element_blank(),
        axis.title=element_blank())
ggsave(filename="plots/selfScore.pdf", width=11, height=10)

## Visualize group score
ggplot(data=combined, aes(x=askTellGroup, y=relationshipTaskGroup)) +
  ylim(c(-100, 100)) +
  xlim(c(-100, 100)) +
  geom_hline(yintercept=0, lty=3, color="grey50") +
  geom_vline(xintercept=0, lty=3, color="grey50") + 
  geom_text(aes(label=person)) +
  annotate(geom='label',
           size=5,
           color="grey50",
           label.size=NA,
           x=c(0, 0, -100, 100),
           y=c(-100, 100, 0, 0),
           label=c("TASK", "RELATIONSHIP", "TELL", "ASK")) +
  annotate(geom='label',
           size=5,
           color="grey50",
           label.size=NA,
           x=c(-80, -80, 80, 80),
           y=c(-80, 80, 80, -80),
           label=c("DOER", "INFLUENCER", "CONNECTOR", "THINKER")) +
  theme_bw() +
  theme(panel.grid=element_blank(),
        axis.title=element_blank())
ggsave(filename="plots/groupScore.pdf", width=11, height=10)

## Visualize differences between self and group
ggplot(data=combined, aes(x=askTellGroup,
                          y=relationshipTaskGroup,
                          color=yearsInLab)) +
  ylim(c(-100, 100)) +
  xlim(c(-100, 100)) +
  geom_hline(yintercept=0, lty=3, color="grey50") +
  geom_vline(xintercept=0, lty=3, color="grey50") + 
  geom_textsegment(aes(xend=askTellSelf,
                       yend=relationshipTaskSelf,
                       label=person),
                   arrow=arrow(length = unit(0.1, "inches"),
                               type="closed"),
                   lineend="round") +
  geom_point() +
  scale_color_gradient(low="grey80", high="black") +
  labs(color="Years in Lab") + 
  annotate(geom='label',
           size=5,
           color="grey50",
           label.size=NA,
           x=c(0, 0, -100, 100),
           y=c(-100, 100, 0, 0),
           label=c("TASK", "RELATIONSHIP", "TELL", "ASK")) +
  annotate(geom='label',
           size=5,
           color="grey50",
           label.size=NA,
           x=c(-80, -80, 80, 80),
           y=c(-80, 80, 80, -80),
           label=c("DOER", "INFLUENCER", "CONNECTOR", "THINKER")) +
  theme_bw() +
  theme(panel.grid=element_blank(),
        axis.title=element_blank())
ggsave(filename="plots/groupToSelfScore.pdf", width=11.5, height=10)