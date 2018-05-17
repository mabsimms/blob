---
title: "Integration through Specification"
date: 2018-05-09T11:22:54-07:00
tags: ["iot", "anti-pattern"]
draft: false
---

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

Large scale IoT projects involve multiple moving parts:

- Embedded devices (hardware design & manufacturing)
- Firmware (software for small connected devices)
- Internet connectivity (direct, proxied, subsumed cost?)
- Mobile applications (software for a range of battery powered supercomputers)
- Services (typically cloud-hosted)
- Data (hot, warm and cold)

Few companies (even Fortune 50 multi-nationals) have the in-house expertise do 
to all of this in a coordinated fashion with a composed engineering process.
Let's take an anonymized (mashed together for five or six different projects)
perspective on launch day, and a reasonable set of decisions (in isolation of
each other) that led to a public meltdown. 

The devices have been built and programmed with care, and are flying off of 
store shelves.  The Internet is abuzz with how "awesomez is the new thing".  
Everything is going well, until suddenly it isn't.  Back end services are 
tipping over, users are reporting non-functional devices, and Twitter is 
abuzz with "this app is #$%#$% slow".

The diagram below outlines the organizational structure that led to the 
precipice of success (and is a very common formula):

- The **Brand Owner** and **Project Management Organization**.  Contoso corp, 
the owner of our fictious IoT experience decided to follow their traditional 
playbook, and work through an outsourced integrated model that's been very 
succesful for prior projects.  

They run the project delivery through a central Project Management Office (PMO) 
staffed with business analysts who are experts at understanding projects, 
timelines and contract management.  This team produces very well written 
specifications on the expected behavior, experiences and expected timelines.
Vendors are sourced, contracts are reviewed and signed, and development begins.

Individual vendors are held to strict timelines for completion of tasks and
functional requirements, with bi-monthly checkpoints and demonstrations of
progress.

- The **Hardware Manufacturer** and **Firmware Developer**.  *Fabrikam* is a 
small but experienced developer of embedded systems (hardware platforms), and 
is branching out into providing firmware and ongoing support for its devices.  
They are contracted with Contoso to deliver devices and firmware per the 
specification leading up to launch day.  

- The **Digital Marketing Agency** and **Back End Service Developer**. 
*Proseware* is a boutique digital marketing agency that won the contract to 
develop the turn key web site and supporting backing services for the launch.

They have built a solid and successful business around truly compelling digital
experiences, and have a team of experienced developers used to working on and
delivering in the face of shifting requirements.  This is their first 
large-scale project for end to end connectivity and device interaction.

Folks who have been through this experience before will have already spotted 
the red flags in this seemingly innocuous narrative (after all, there are only
three primary players in this supply chain, and automobiles are routinely built
with thousands of suppliers...).  Let's tease apart the common failure modes or
gaps.

## Integration via Specification

Specifications are a durable proxy for communication of intent.  They are 
wonderful and necessary things, but are susceptible to subtle interpretations
of detail or intent.  Without clear, open and defined channels of communication
between the various players involved in the end to end delivery these gaps 
become enshrined in code and content.  

One common anti-pattern I've observed when working with outsourced development
efforts is the fire-and-forget approach where specs are thrown over the wall
and functional code/hardware is thrown back (or even worse, when vendors 
involved in the development of an integrated solution are contractually 
barred from communciating with each other - even by proxying through the PMO).

Let's take a simple example from a project I was asked to assist with.  The
protocol definition for how devices would communicate with back end services 
was defined in a well written specification, listing each expected message 
type and response.  The firmware team developed the message for updating the
current location of a device as follows:

{{< highlight c >}}
struct Location
{
    int altitude;
    int heading;
    ...
}
{{< / highlight >}}
 
The back-end services team read the same specification and came up with their
interpretation of the same specification:

{{< highlight csharp >}}
[StructLayout(LayoutKind.Sequential, Pack=1)]
public struct Location
{
    [MarshalAs(UnmanagedType.U4)]
    public int altitude;

    [MarshalAs(UnmanagedType.U4)]
    public int heading;
}
{{< / highlight >}}

This bug was happily caught through code review when comparing some erroneous
simulation results, but had it slipped into production could have caused some
rather nasty reactions when the altitude value was accidentally marshalled as
an unsigned integer. 

{{% note %}}
A better approach here would have been a formal specification of the 
**versioned** communication protocol in something like Bond or Protobuf, held
in a common repository managed by the brand owner, which all of the development
teams could use a common asset.
{{% /note %}}

Other forms of this anti-pattern being the root cause of overall systemic
failure are sprinkled through the rest of this blog series.

## Trusted but Unverified (Lack of Technical Autocracy).

The two key red flags in the description of the Project Management Office for 
Contoso were:

- The lack of engineering processes, or technical governance over the
delivery of a highly integrated, public experience with **brand exposure**.  

- Accountability for (strictly) functional requirements.

This is not to say that project management offices and procedures aren't
appropriate or necessary, but rather that given the usual degree of exposure 
for a public IoT solution and tight delivery timeframes, the Brand Owner needs
technical eyeballs and delivery accountability on the solution and how it is 
delivered (which in turn needs to be baked into the contracts).

Furthermore, non-functional requirements (**scale**, **availability** and 
**manageability**) need to be built into the delivery timeframe and contractual
accountabilities.  While these can be (and often have to be) retrofitting into
solutions when performance or stability issues are discovered (unfortunately,
often on launch day), this is a very expensive way of doing business.

{{% note %}}
An engineering budget for non-functional requirements needs to be baked into
budgets, contracts, testing and project review.  The more succesful your 
product or project, the more important this is.
{{% /note %}}

Project milestone and progress reviews need to incorporate non-functional
goals, based on shared, live dashboards.  These need to be (as soon as is
practical) based on integrated end-to-end evaluations.

## One Methodology to Rule Them All

Forcing very different cadences of software development (mobile, services, 
embedded) into one management methodology to "rule them all".  Different 
component teams in an overall delivery project are naturally going to be 
delivering at different cadences with different risk levels.  

Attempting to force all of these component teams into the same engineering 
process or management cadence leads to unnatural behavior.  For example, 
firmware releases have an inherently higher risk than cloud service releases 
(especially if devices have limited over-the-air update capability):

- A cadence that tries to force alignment with a firmware ship cycle may  
artificially inhibit the ability of cloud service and mobile teams to iterate quickly. 

- A cadence that tries to force alignment with cloud services ship cycle may 
 push risky release gates into the firmware development team.

 Any overall development and governance methodology needs to enable each class 
 of workstream to optimize for their risk level and desired release cadence, 
 together with an alignment process and structure to coordinate shared dependencies
 and work through priority inversion challenges.

## No Process to Balance Competing Engineering Priorities

Leading out of one methodology to rule them all is the need for a mechanism or process
to balance competing engineering priorities.  This will happen at both a component
or stream level, or a global system level (often centered on the issue of priority inversion).

Without a structure or approach to discuss and balance competing priorites, projects often
fall prey to local optima that lead to unpleasant end user experiences.

## Divergent Engineering Systems

Outsourcing contracts rarely dictate choices or composition of engineering
systems.  This often leads to a divergent mess of different source code 
control systems, build pipelines, versioning mechanisms, deployment, 
configuration management and integrated testing approaches.

Given the impracticality of global simultaneous updates to individual systems
(also known as instantly shipping and propagating your bugs to all of your
users at the same time), there will always be multiple versions of each 
component active (unless the solution allows for planned downtime).

With every moving part or component, the impedence for delivering a functional
end to end experience increases exponentially.  Any system that requires 
human interaction to create a functional set of builds (especially in an 
environment where multiple versions of each component are active at the same
time) increases risk and the time required to add a feature or fix a bug. 

{{% note %}}
One project I was helping out with a while back was being built between multiple
internal teams and outsourced vendors.  Due to contractual obligations (or more
precisely, the lack thereof), none of the individual component teams (firmware, 
mobile or cloud) had any common repositories or build systems. 

To compound the problem, there was no common convention to track version/build 
numbers in telemetry, nor any way to trace those version or build numbers back to 
a specific branch or build.  Needless to say, diagnosing live site isses was an 
adventure :)
{{% /note %}}

## Testing in Isolation

One of the common failure modes for a highly divergent development and delivery
approach is testing in isolation, where the first time that all of the pieces
of a solution (devices, services and mobile) come together under load is at
production launch.

Subtle differences in behavior and semantics between real devices, and load 
generation / simulation environments can produce unpleasant production 
surprises (also known as low-latency learning moments). 

{{% note %}}
One project I was asked to help out really brought this anti-pattern home.  The 
particular project was a launch event (think marketing event or sporting event) that
had melted down under conditions of extreme success.  

During the retrospective it came out that the site had been load tested to 2x 
projected peak volume, but the load testing engine was multiplexing load through 
the same TCP connections. The site had plenty of backend capacity (web servers,
databases, etc) but hadn't allocated enough front end capacity for all of the inbound
connections.
{{% /note %}}

## No Single Pane of Glass

IoT solutions are complex systems with multiple moving parts interacting 
in dynamic, and osmetimes unanticipated ways.  Their complexity defies easy
comprehension without timely, accurate and consumable data that correlates
behavior and activity across systems.

The single greatest barrier I've encountered when attempting to remediate or 
resolve performance or availability issues with deployed applications is the 
lack of a single pane of glass that allows all of the development and 
operations teams involved in the end to end experience to make **informed
data driven engineering decisions**.

This is a fairly nuanced and complicated topic, and I'll cover it in another
blog series.  In terms of patterns, the key thing to bear in mind is the need
to allocate an engineering budget to develop and evolve a monitoring and 
diagnostics data pipeline.

{{% note %}}
Production diagnostics without a single pane of glass (also known as "guessing") 
is a painful exercise, fraught with uncertainty, pain and suffering.  Production
diagnostics with multiple panes of glass, each isolated to an individual component
team (also known as "conditions for blamestorming") is a compounded exercise in 
uncertainty and frustration.  
{{% /note %}}
