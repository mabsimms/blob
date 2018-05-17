---
title: "Anti-Patterns for Internet of Things Applications"
date: 2018-05-09T11:20:14-07:00
draft: false
tags: ["iot", "anti-pattern"]
---

Over the past eight years I've had the opportunity to work on a wide variety of
Internet of Things (IoT) applications, from automobiles, to beverage machines,
thermostats and everything in between.

While there are always specific aspects and challenges in any large scale
IoT project delivery, I've run into the same set of six or seven key 
anti-patterns on nearly every project.  While I've had a deck floating around
in various engagements for a couple of years, had enough asks to sit down and
flesh it out in a readable (hopefully :) form.

Each of the posts in this series will work through one of the common 
anti-patterns I've encountered, how to identify those potential anti-patterns 
in your approach, and some suggestions for excising addressing them in 
your solution.

Note that many of these anti-patterns do not pose challenges except under
conditions of extreme success (when all of the stress points in your end to
end experiences are exposed by the harsh light of popularity). 

All of the examples, data and code snippets in this presentation are drawn 
from (multiple) production applications and services.  Most of these 
anti-patterns are obvious in hindsight.  You will rarely have the luxury of 
a time machine.  **In isolation of the overall system each of the decision 
points that led to these anti-patterns makes total sense**.

To make things more fun – these are the anti-patterns that occur at scale 
after you have delivered a perfectly functionally correct concurrent system.
None of the patterns or approaches used in this presentation are inherently 
language or platform specific (some of the code used to demonstrate is). They are artifacts of the physics and behavior of connected, distributed 
systems at hyper scale.

## Integration through Specification

[Integration through Specification](iot-anti-patterns-integration.md)

Successful delivery of an IoT
project at scale brings together multiple areas of expertise, processes and
organizations.  Each of the individual components carry with them 
assumptions and assertions about how the world works, and how product is 
designed, implemented (or manufactured).  

Take the simple example of a home thermostat - involving embedded device 
manufacture, firmware development and maintenance, cloud connectivity, 
distibuted back-end services and mobile applications.  In the small this 
could involve a small development team adapting off the shelf hardware; in
the large this could be multiple divisions of a multi-national corporation 
outsourcing individual sub-components with strict information and awareness
firewalls between delivery teams.

This, more so than any other anti-pattern in this series, has been at the 
heart of challenging projects, and is the hardest to fix when timelines are 
short and tempers are high.  Having a coordinated engineering and 
communication process across the end-to-end delivery experience is crucial
in the efficient and successful delivery of IoT experiences at scale.

## Physics? Expecting Devices to Adapt to Services

TODO

## Devices Hosting Services

TODO

## Phase Lock the World

TODO

## Global Identity

TODO

## Remote Concrete Dependencies

TODO

## Queues Demand Respect

TODO

## Message Conversion Efficiency

TODO

## You're Building a Platform.  Even if you don't want to be

TODO

