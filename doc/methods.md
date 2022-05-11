


### Remarks about data analysis

The data are analyzed in the Bayesian paradigm using hierarchical models
[@gelman2003bda; @gelman2006data; @mcelreath2018statistical; @nicenboim2021introd_bayes_data].
Before turning to the actual experiments, we will here briefly summarize
general properties of the models to be considered.

In Bayesian data analysis one specifies the likelihood, and the prior
distributions over parameters of interest. The analysis results in
posterior probability distributions of plausible values for a given
model and data. We report medians and 95% credible intervals (CRI),
i.e. the range of values for which we can be 95% certain that the true
effect lays therein. An important feature of Bayesian analysis is uncertainty highlighting, and the width of the intervals can be used to assess uncertainty of the parameters values

Beside two special cases the prior distributions used for modelling were "weakly informative" [@gelman2003bda] p. 55. This means they contain little real-world knowledge and a priori they do not exclude any observable values. With the exception of the two already mentioned cases, the prior distributions were also constructed in such a way which would not pull the results in any direction. We wanted to remain agnostic both about the size and the direction of the effects.
The details of the prior distributions are specified when
discussing each experiment.

Unless explicitly stated otherwise, models used 4 sampling chains with
4000 samples drawn from each chain. Half of these samples were discarded
for warm-up, hence each model had 8000 samples available for the
analysis. Trace plots were visually inspected to identify convergence
issues. Additionally, only the models with all $\hat{R} \leq 1.01$,
which suggest convergence, were used in the analyses.

All the models used were fit with a full variance-covariance matrix,
i.e. they were so-called maximal models. Using Bayesian modelling often
allows to fit complex models without convergence issues.

The models used for the analysis of the eye-tracking data used
log-normal likelihood or a mixture of log-normal distributions. We assumed log-normal likelihood since reading
times data are approximately log-normally distributed and therefore our
model can resemble the data generating process more closely [see
@rouder2008hierarchical; @Nicenboim_2016; @nicenboim2018explor_confir
for a more detailed discussion].

All the data analyses were conducted in the R software for statistical
computing [@Rcore], and particularly with the use of the brms 
[@bürkner2017brms] and rstan [@team2020rstan] packages, which use Stan [@stan2021] probabilistic
language.

### model description

All the models took into
account three predictors and their interactions as fixed effects: the type of
quantifier, object match/mismatch, and subject match/mismatch. Participant number and item number
were used as random effects. 

These measures were considered: total fixation duration, re-reading
duration,
first pass regression path, first pass first gaze, first pass
total gaze,
probability of regression, and probability of re-reading. For the
total fixation duration, re-reading duration, regression frequency and
re-reading frequency a model was fit to every region
the measure was taken on. For the rest of the measures, the models were only fit
to the critical region (6-7th word), post-critical (8th word), and
post-post-critical (9th) region.




Three types of models were fit. First group concerned the data in the total fixation duration and re-reading duration. What follows is the prior distributions specification for the first group of models.
For the intercept we used a normal distribution with
$\mu = 0$ and $\sigma =  10$. 
For the slopes we used a normal distribution with
$\mu = 0$ and $\sigma =  1$. 
Even though these choices inform our inferences very weakly, to 
ensure that they are inline with domain knowledge we evaluated them with prior predictive checks. 

As a prior distribution for both the standard
deviations of the random effects, and for the residual variance, 
we used a truncated normal with 
$\mu = 0$ and $\sigma =  1$. 

For the random effects correlation between the intercept and the slope we used
the LKJ distribution [@lewandowski2009gener; @stan2021] with $\eta = 2$.

The second group of models were the models fit to the data from the first pass first gaze, and first pass total gaze measures.
We started the analysis by using
 exactly the same models as for the measures just discussed,
but visual examination of the posterior predictive checks revealed that the
models did not fit well. Because of this we decided to use a likelihood which
comprised of a mixture of two log-normal distributions. One of the distributions
was the same distribution as used in the previous model, the other had an
additional shift parameter added to the distribution's location. The rate at which
the samples were drawn from each of the components was controlled by a parameter
$\theta$.

The likelihood for these models is specified below:

$$ y_{i} \sim \theta \times logNormal(\mu_{i}, \sigma_{1}) + (1 - \theta) \times logNormal(\mu_{i} + \delta, \sigma_{2}) $$

Beside these new parameters, the prior distributions used for these models were the same as in the previous models.
For the additional parameters, we used normal distribution with $\mu = 2, \sigma = 1$ for the $\delta$ parameter since we wanted the second mixture component to be shifted forward with respect to the other component. For the $\theta$ parameter, beta distribution with $\alpha = 10, \beta = 2$ was used.
We decided on a such a strongly principled prior distribution in order to put more weight on the shifted component of the mixture.



Finally, the last group of models consisted of the models fitted to the frequencies of regressions and re-readings. These models used Bernoulli likelihood with logit link function. They used the same predictors as the other models but slightly different prior distributions.

For the intercept we also used a normal distribution, though a narrower one. The mean was 
$\mu = 0$ and $\sigma =  1.5$. 
We made these choices based on prior predictive checks. A wider normal distribution resulted in most of the probability density being concentrated around 1 or 0, which is unreasonable. A priori we should assume that the probability of re-reading or regressing is concentrated around 0.5.
The rest of the parameters used the same prior distributions as in the models described earlier.