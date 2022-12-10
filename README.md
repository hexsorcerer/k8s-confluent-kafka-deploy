# k8s-confluent-kafka-deploy
A collection of scripts to make it easy to deploy the non-enterprise components
of confluent kafka.

# Inspiration
I'm wanting to deploy a kafka setup in k8s, and confluent seems like the go-to
version these days. Confluent provides
[Confluent for Kubernetes (CFK)](https://docs.confluent.io/operator/current/co-deploy-cfk.html)
to easily deploy a full working setup, but this also installs the
enterprise-only components, and I'd prefer to not have those.

I looked around to see if there was a nice simple solution, and while there are
solutions, none of them were as simple as I preferred, so I thought I'd come up
with my own.