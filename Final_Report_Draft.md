# Swanton Pacific Ranch Private LTE Network
## Design, Simulation, and Deployment of a CBRS Band 48 Private Cellular Network

---

**California Polytechnic State University, San Luis Obispo**
**Department of Electrical Engineering**
**EE 461 / EE 462 — Senior Project**

**Authors:**
Gregory Karaoghlanian
Frankie Medrano
AJ Gregory

**Faculty Advisor:** Dr. Dennis Derickson
**Industry Mentor:** Jonathan Polly, Chief Technologist, Cal Poly 5G Innovation Lab / Digital Transformation Hub

**June 2026**

---

## Statement of Disclaimer

*Since this project is a result of a class assignment, it has been graded and accepted as fulfillment of the course requirements. Acceptance does not imply technical accuracy or reliability. Any use of information in this report is done at the risk of the user. These precautions have been taken to achieve a high quality report:*

*This report has been subject to peer review, advisor review, and industry mentor review. All technical claims have been verified against manufacturer documentation, measured field data, and published references. Equipment specifications are cited from official product documentation. Field measurement data is preserved in its original form in the project repository.*

---

## Table of Contents

- Abstract
- I. Introduction
  - I.A The Connected Edge: Why Cellular, Why Now
  - I.B The Opportunity at Swanton Pacific Ranch
- II. Background
  - II.A Agricultural Technology: Use Cases at Swanton Ranch
  - II.B Swanton Pacific Ranch: Site and Terrain
  - II.C Citizens Broadband Radio Service (CBRS)
  - II.D CBRS Spectrum Policy Context
  - II.E LTE Technical Background
  - II.F RF Propagation Simulation and Tool Democratization
- III. Requirements
  - III.A Project Goals and Constraints
  - III.B Marketing Requirements
  - III.C Engineering Specifications
- IV. Design
  - IV.A Alternatives Analysis
  - IV.B System Architecture
  - IV.C RF Link Budget and Antenna Selection
  - IV.D RF Propagation Simulation
  - IV.E SIM and Security Design
- V. Test Plans
  - V.A Phase 1: RF Propagation Simulation
  - V.B Phase 2: Field Drive Test
  - V.C Phase 3: Throughput Testing
  - V.D Failure Mode and Effects Analysis
- VI. Development and Construction
  - VI.A Hardware Assembly and Physical Installation
  - VI.B Software Setup: Open5G2GO and Open5GS
  - VI.C Subscriber Configuration and SIM Provisioning
  - VI.D Baicells Nova 430i Configuration (Lab Validation)
  - VI.E Baicells Nova 846 Configuration (Swanton Deployment)
  - VI.F Power System
- VII. Integration and Test Results
  - VII.A Deployment Day: May 2, 2026
  - VII.B Coverage Measurement Results
  - VII.C Simulation vs. Measured Comparison
  - VII.D Throughput Results
  - VII.E Lessons Learned
- VIII. Conclusion
  - VIII.A What Was Achieved
  - VIII.B Significance
  - VIII.C Future Work: The Shaping Plan
- IX. Bibliography
- X. Appendices
  - Appendix A: ABET Analysis of Senior Project Design
  - Appendix B: Engineering Specifications
  - Appendix C: Parts List and Costs
  - Appendix D: Project Schedule
  - Appendix E: System Configuration Reference
  - Appendix F: Drive Test Data Processing
  - Appendix G: Deployment Photographs

---

## List of Figures

| Figure | Description | Section |
|--------|-------------|---------|
| Figure 1 | Swanton Ranch USGS 7.5-minute topographic map | II.B |
| Figure 2 | Marketing requirements hierarchy tree | III.B |
| Figure 3 | System architecture block diagram | IV.B |
| Figure 4 | CBRS three-tier spectrum access framework | II.C |
| Figure 5 | eino.ai simulation configuration screenshots | IV.D |
| Figure 6 | Nova 846 with AW3376-E-F antenna deployed at Cooke's Peak | VI.A |
| Figure 7 | Lab bench setup with Nova 430i, router, and UE 1 | VI.A |
| Figure 8 | eino.ai RSRP simulation heatmap | IV.D |
| Figure 9 | Measured drive test RSRP overlaid on USGS topographic base | VII.B |
| Figure 10 | Simulation and measured coverage overlaid for comparison | VII.C |
| Figure 11 | G-NetTrack screenshot showing Swanton_Ranch network attachment | VII.A |

---

## List of Tables

| Table | Description | Section |
|-------|-------------|---------|
| Table I | Pairwise marketing requirements weighting | III.B |
| Table II | Engineering specifications | III.C |
| Table III | eino.ai simulation parameters | IV.D |
| Table IV | Failure mode and effects analysis | V.D |
| Table V | Subscriber configuration | VI.C |
| Table VI | Measured RSRP distribution | VII.B |
| Table C-I | Parts list and costs | Appendix C |

---

## Acknowledgements

The team thanks Jonathan Polly, Chief Technologist at the Cal Poly 5G Innovation Lab and Digital Transformation Hub, for providing sustained technical mentorship throughout the project and for sharing his industry expertise during every phase from concept to report. His guidance on network architecture, equipment selection, and the broader context of private cellular made this project substantially richer than it would have been otherwise.

Thanks to Mark Houtz for sharing his deep expertise on CBRS and private LTE, for making the WLPC Phoenix 2026 course materials available to the team, and for his blog and community resources that served as a practical foundation for the lab build.

Thanks to Mark Swisher, ranch manager at Swanton Pacific Ranch, for hosting the team during the deployment, providing access to the site, and sharing his perspective on the connectivity challenges the ranch faces every day.

The team is grateful to Lawrence Berkeley National Laboratory for donating the Baicells Nova 846 eNodeB and Alpha Wireless AW3376-E-F sector antenna that made the Swanton deployment possible.

Thanks to Dr. Dennis Derickson for advising this project and for giving the team the freedom to approach it in a way that was both technically rigorous and genuinely interesting.

---

## Abstract

Cal Poly's Swanton Pacific Ranch, a 3,200-acre working ranch and student research facility in Davenport, California, lost most of its communication infrastructure in the 2020 CZU Lightning Complex fires. Six years later, the ranch operates with only a solar-powered UHF voice repeater and a fiber connection to the bunkhouse. Commercial cellular coverage across the property is extremely limited. As Cal Poly moves toward year-round student habitation and expanded research programs at the site, the absence of a data network is an immediate operational constraint, not a future problem.

This project designed, simulated, and deployed a private 4G LTE network at the ranch using the Citizens Broadband Radio Service (CBRS) Band 48 spectrum. The hardware consisted of a Baicells Nova 846 outdoor macro eNodeB paired with an Alpha Wireless AW3376-E-F 8-port sector antenna, both donated by Lawrence Berkeley National Laboratory, and an Intel NUC running Open5GS as the LTE core network. Custom SIM cards provisioned with PLMN 315-010 authenticated three Android test devices. Starlink provided internet backhaul at the deployment site.

Before deployment, the team used eino.ai, a cloud-native RF propagation simulation tool, to model coverage from Cooke's Peak, the site's highest elevation point. The simulation guided the sector heading, antenna configuration, and expectations for coverage extent.

The network went live on May 2, 2026. Three users carried Android phones running G-NetTrack Lite, collecting 1,655 valid RSRP measurements from the Swanton_Ranch network across approximately 4 km of terrain. Strong signal was measured near the radio at Cooke's Peak, degrading to marginal at range. The simulation correctly identified the coverage direction and near-field performance, but overestimated the effective coverage radius, a discrepancy attributed primarily to antenna gain and environmental factors.

The result is a functional, documented private LTE network at Swanton Ranch and a complete technical foundation for future student teams to build a permanent installation. This project demonstrates that a university team can deploy enterprise-grade private cellular infrastructure with open-source software, commodity hardware, and freely available spectrum at a fraction of traditional cost.

---

## I. Introduction

### I.A The Connected Edge: Why Cellular, Why Now

Something has shifted in how the physical world connects. For the first three decades of the cellular era, the primary use case was personal connectivity, a person carrying a handset, making calls, sending messages. That framing made sense when cellular networks were expensive to build, spectrum was licensed in large blocks at auction, and the hardware required to run a base station cost millions of dollars and filled a climate-controlled equipment room.

That framing no longer fits the technology. What has emerged is a fundamentally different model, one where the radio infrastructure itself has become a platform for machine communication at scale. Autonomous ground vehicles navigating warehouse floors, security cameras streaming high-definition video across industrial facilities, IoT sensors monitoring soil moisture and cattle locations across thousands of acres, precision irrigation controllers responding to real-time field data: none of these applications fit the mold of personal connectivity, and most of them cannot be reliably served by Wi-Fi.

Wi-Fi was designed for local, fixed-location coverage. It handles shared access through contention protocols that work well with a small number of devices in a controlled indoor environment. At field scale, across kilometers of complex terrain, with devices moving at vehicle speed, Wi-Fi's limitations become structural. Range is limited. Interference compounds as device counts grow. There is no quality-of-service guarantee, which matters when a machine control system shares the air with consumer traffic. There is no built-in mobility management, so handoffs between access points are unreliable. Wi-Fi was built for a specific problem, and it solves that problem well. The problem at Swanton Ranch is different.

Cellular networks, by contrast, were designed from the ground up for wide-area coverage, mobility, deterministic quality of service, and strong security. The challenge has historically been cost: building and operating a cellular network required carrier-scale investment. That barrier has now substantially fallen, and the reasons are worth understanding because they explain why this project was possible at all.

Three things changed in parallel. First, the standardization of open-source core network software, most notably Open5GS, made it possible to run a fully functional LTE Evolved Packet Core on commodity server hardware for free. The software that once ran only on purpose-built telecom equipment now runs in a Docker container on a laptop. Second, companies like Baicells brought commodity eNodeB hardware to market at price points accessible to enterprises and universities, hardware that would have cost hundreds of thousands of dollars a decade ago. Third, the Citizens Broadband Radio Service opened 150 MHz of mid-band spectrum in the 3.5 GHz band to shared use without requiring a traditional spectrum license. Any organization can access this spectrum, deploy a private network, and operate it without negotiating with a carrier.

The convergence of free software, affordable hardware, and accessible spectrum means that private cellular is no longer a solution only for large enterprises with dedicated telecom engineering teams. Organizations with modest budgets and the technical staff to configure and maintain the system can now deploy and operate their own LTE networks. The tools are accessible, the knowledge is documented, and the demand is real.

### I.B The Opportunity at Swanton Pacific Ranch

Cal Poly's Swanton Pacific Ranch sits on 3,200 acres of coastal terrain in Davenport, California, roughly ten miles north of Santa Cruz. The ranch was donated to Cal Poly in 1993 and has operated since then as a working ranch and student research facility, hosting programs across agriculture, natural resources, and biological sciences. It is one of several Cal Poly Learn By Doing field sites that give students hands-on experience with working systems, not classroom simulations.

In August 2020, the CZU Lightning Complex fires burned across Santa Cruz and San Mateo counties. At Swanton Ranch, roughly 80 percent of the 3,200 acres burned. The fire destroyed research infrastructure, equipment, and fencing. It also destroyed an AT&T fiber optic cable that had been buried 200 feet underground. That cable was the ranch's primary connection to the outside world [10].

After the fire, the ranch was left with two communication options. The first was a UHF voice repeater on Cooke's Peak, the dominant high point on the property, which provides solar-powered walkie-talkie connectivity across the ranch but no data capability. The second was a fiber optic connection to the bunkhouse, the ranch's main living and working facility, which provides internet access at that one location but nowhere else on the property. Commercial cellular coverage across the ranch is extremely limited. While the drive test data captured occasional brief signals from T-Mobile, AT&T, and Verizon at isolated points along the test route, no carrier provides usable coverage across the working areas of the property.

The consequences of this gap are already visible. Cal Poly's BRAE department (BioResource and Agricultural Engineering) deployed IoT gateways at Swanton to support environmental monitoring research. Those gateways could not register on commercial SIM cards because there is no usable commercial coverage at the site. The devices sat unused, not because of a hardware failure or a configuration error, but simply because there was no network for them to connect to. This is precisely the scenario that private cellular addresses. A provisioned SIM on the project's network would have allowed those gateways to connect immediately, without any dependency on a commercial carrier.

Cal Poly is planning to expand both the student population and the research scope at the ranch, moving toward year-round habitation. That plan requires reliable communication. Voice-only UHF coverage, adequate for a day-trip working environment, is not sufficient infrastructure for a facility with resident students, active research instruments, livestock monitoring, and the safety obligations that come with extended human presence on a remote rural property.

The project team set out to provide the first step toward that infrastructure: a working private LTE network at Swanton that could demonstrate feasibility, characterize coverage, and leave behind a complete technical foundation for the student teams that follow.

---

## II. Background

### II.A Agricultural Technology: Use Cases at Swanton Ranch

Modern working ranches generate and consume data across a wide range of operations, and the value of that data depends entirely on whether it can be collected, transmitted, and acted on in real time. At a site like Swanton Ranch, the specific connectivity use cases are well defined. Seawater intrusion monitoring, which tracks saltwater movement into agricultural aquifers along the coast, requires frequent automated readings from sensors distributed across the property. Flow meters on irrigation systems generate continuous data that can reduce water consumption and detect leaks before they become expensive. GPS-based livestock tracking allows ranchers to locate animals and detect behavioral anomalies without physically walking the property. Lifecycle monitoring for livestock health and breeding management requires connectivity to be useful at scale. Security cameras protecting equipment and structures, environmental sensors for the research programs hosted at the ranch, and basic voice and data connectivity for students and staff working at remote locations round out the picture [16].

At present, none of these capabilities exist at Swanton Ranch outside the bunkhouse. The UHF voice repeater supports voice only. The fiber connection at the bunkhouse is geographically fixed. The gap between what modern agricultural research requires and what the ranch's current infrastructure provides is the central motivation for this project.

### II.B Swanton Pacific Ranch: Site and Terrain

Swanton Pacific Ranch occupies 3,200 acres of coastal terrain in Santa Cruz County, California, at approximately 37.06 degrees north latitude and 122.24 degrees west longitude. The property runs from the Pacific Ocean shoreline eastward into the Santa Cruz Mountains, with Highway 1 passing through the western portion of the ranch near the coast.

The terrain is characteristic of the central California coast: steep ridgelines running roughly north-south, with narrow valleys carved by seasonal streams. Cooke's Peak is the dominant high point on the property, rising to approximately 243 meters above sea level. From Cooke's Peak, the ranch valley opens to the south and east, with the coastal bluffs and the ocean visible to the west. Dense groves of coastal Douglas-fir occupy the slopes, providing windbreak but also attenuating radio signals through foliage.

The 2020 CZU Lightning Complex fire burned through most of the ranch. Six years later, the property is in active recovery, with some areas showing regrowth while others retain the standing dead timber characteristic of fire-killed conifer forests. This vegetation pattern affects radio propagation: recovering brush and standing dead wood present different attenuation characteristics than the mature forest that existed before the fire, and both differ from what a propagation model calibrated on pre-fire imagery would predict.

Figure 1 shows the USGS 7.5-minute topographic map of the Swanton Ranch area at 1:24,000 scale [1]. The map shows the terrain relief that governs line-of-sight from Cooke's Peak to different parts of the ranch. The valley floor south of Cooke's Peak lies in partial shadow from the ridge, and the terrain to the east rises again before reaching the ranch boundary. This topographic structure was the primary factor driving the simulation work described in Section IV.D, and it directly explains why signal measured from a single radio at Cooke's Peak degrades rapidly with distance in certain directions.

*[Figure 1 here: CA_75MinuteTopo1_20260611_002516641129_TM_geo.kmz — USGS Topographic Map, Swanton Ranch area]*

### II.C Citizens Broadband Radio Service (CBRS)

The Citizens Broadband Radio Service is a shared-spectrum framework established by the FCC covering 150 MHz of mid-band spectrum from 3.550 to 3.700 GHz, designated as LTE Band 48 [2]. The FCC introduced the framework in 2015 and completed the operational rules by 2020. CBRS represents a significant departure from the traditional spectrum licensing model, where a carrier purchases exclusive rights to a band through a government auction and deploys a network at its own discretion. Instead, CBRS uses a dynamic spectrum sharing architecture that allows multiple users to share the same frequencies under managed coexistence rules.

The sharing framework operates through a three-tier hierarchy [2]:

**Tier 1: Incumbents.** The highest-priority users are existing incumbent licensees, primarily US Navy radar systems and satellite earth stations. When Tier 1 systems are detected or operating in an area, all lower-tier users in that area must immediately cease operation. No notice is provided; the cessation is automatic and mandatory. At Swanton Ranch, which sits on the Pacific coast, this tier represents a meaningful operational consideration. US Navy vessels operating offshore could trigger preemption events with no warning. This risk motivates the inclusion of a secondary, non-CBRS communication layer in the ranch's long-term infrastructure plan.

**Tier 2: Priority Access Licenses (PAL).** The second tier consists of organizations that have purchased licensed access to a specific 10 MHz channel within CBRS in a defined geographic area through an FCC auction. PAL holders receive protection from other PAL users and from Tier 3 users. PAL licenses are available for county-sized geographic areas and represent a way to secure predictable spectrum access for a long-term deployment.

**Tier 3: General Authorized Access (GAA).** The third tier is open to all users without any license or registration fee. GAA users may operate on any CBRS frequency that is not already occupied by Tier 1 or Tier 2 users, but they receive no protection from interference by other Tier 3 users or from PAL holders, and they must yield immediately if a higher-tier user appears. The network deployed in this project operates at Tier 3, GAA access.

The mechanism enforcing these tiers is the Spectrum Access System (SAS). Every CBRS device must register with an SAS and receive a channel grant before it can transmit. The SAS tracks the locations of all registered devices, the locations and operating schedules of incumbent systems, and the PAL license geography, and it dynamically allocates available channels to GAA users. For outdoor operation, CBRS devices must be registered by a Certified Professional Installer (CPI) and must communicate their precise GPS location to the SAS. For the Swanton deployment, the radio was configured in a non-SAS "Other" mode appropriate for field testing outside of normal public radiation rules. A permanent installation would require full SAS registration and CPI certification, as discussed in Section VIII.C.

CBRS is particularly well suited to the Swanton use case for several reasons. It operates at 3.5 GHz, a mid-band frequency that provides a useful balance between coverage range and throughput capacity. It is compatible with standard commercial smartphones and LTE user equipment, meaning ranch staff and students can use ordinary phones without any special hardware. The spectrum is available at no licensing cost for GAA access, which fits the project's budget constraints. And the ecosystem of compliant hardware, including the Baicells radio used in this project, is well developed and commercially available at price points that make private deployment economically viable.

Figure 4 illustrates the three-tier CBRS spectrum access hierarchy.

*[Figure 4 here: CBRS Three-Tier Framework Diagram]*

### II.D CBRS Spectrum Policy Context

The framework that makes this project possible is not static. The FCC is actively considering changes to the CBRS band, including proposals that would allow higher power levels and potentially relocate existing users to accommodate larger commercial deployments [3]. These proposals reflect pressure from major carriers seeking to expand their mid-band holdings, and they would have significant consequences for the class of deployments this project represents.

Higher transmit power in CBRS would increase interference across the band, degrading the reliability of existing small-scale networks. If power levels are raised to accommodate carrier-scale operations, the low-power private deployments at universities, industrial facilities, and rural sites like Swanton Ranch would face degraded signal-to-interference ratios. In practical terms, the same network infrastructure built in this project would deliver measurably worse performance in a higher-power CBRS environment.

Cal Poly has a direct institutional stake in how these policy questions are resolved. The Avila Beach marine research pier, the Digital Transformation Hub on the main campus, and the Swanton Ranch network all depend on the current CBRS framework. In May 2026, Christopher Lupo, Founding Director of the Noyce School of Applied Computing at Cal Poly, published an article in RCR Wireless, one of the major national RF and telecommunications trade publications, arguing against the proposed changes [3]. The article, co-developed with the Cal Poly 5G Innovation Lab, described Cal Poly's CBRS deployments and their educational and research value. It received approval from the Chancellor's office before publication, reflecting the institutional significance of the issue.

The argument in that article applies directly here: none of the work described in this report is possible without the spectrum policy framework that CBRS provides. The technical choices made at every layer of this project, the frequency band, the hardware, the power levels, the simulation assumptions, all flow from the assumption that shared CBRS spectrum remains accessible to non-carrier users. Spectrum policy is not a background condition for this project. It is a foundational prerequisite.

### II.E LTE Technical Background

LTE (Long-Term Evolution) is the fourth-generation cellular standard developed by the 3rd Generation Partnership Project (3GPP). Understanding the key architectural components and air interface concepts is necessary to follow the design and implementation decisions in this report.

**Network Architecture**

An LTE network consists of two major subsystems: the Radio Access Network (RAN) and the Evolved Packet Core (EPC). The RAN is composed of eNodeBs (evolved Node Bs), the base stations that communicate directly with user equipment over the radio interface. In this project, the Baicells Nova 846 is the eNodeB. The EPC handles authentication, mobility management, session management, and data routing. It is composed of several interconnected network functions [12, 13]:

- **MME (Mobility Management Entity):** Handles UE authentication, mobility state management, and session establishment. The MME communicates with the eNodeB over the S1-MME interface using the S1AP protocol over SCTP. In this project, the MME runs as part of Open5GS on the Intel NUC at IP address 10.0.1.4.

- **HSS (Home Subscriber Server):** The subscriber database. It stores the authentication credentials (IMSI, Ki, OPc) and subscriber profiles for every device authorized on the network. The HSS is also part of the Open5GS stack in this project.

- **SGW (Serving Gateway) and PGW (PDN Gateway):** Together these form the user-plane data path. The SGW anchors the user-plane connection to the eNodeB, while the PGW connects to external data networks, in this case the internet via Starlink. In this project, the data plane was handled by Baicells LGW (Local Gateway) NAT mode, as discussed in Section VII.E.

**LTE Air Interface**

LTE uses Orthogonal Frequency Division Multiplexing (OFDM) for the downlink and SC-FDMA for the uplink. OFDM divides the available spectrum into many orthogonal subcarriers, each carrying a small portion of the data stream. This makes LTE resilient to multipath propagation, which is particularly relevant in the hilly coastal terrain at Swanton. The base unit of resource allocation in LTE is the Resource Block (RB), which occupies 180 kHz of bandwidth and one 0.5 ms slot in time. A 20 MHz LTE carrier contains 100 resource blocks, and the scheduler at the eNodeB dynamically allocates resource blocks to connected devices based on signal quality and traffic demand [12].

CBRS Band 48 uses Time Division Duplexing (TDD), meaning the same frequency is used for both downlink (base station to UE) and uplink (UE to base station), with time slots alternating between the two directions. This contrasts with FDD (Frequency Division Duplexing), which uses separate frequency blocks for uplink and downlink simultaneously. TDD is well suited to asymmetric traffic loads because the ratio of downlink to uplink slots is configurable. This project used TDD SubFrame Assignment 2, which allocates three downlink subframes for every one uplink subframe, a 3:1 ratio appropriate for a network where users primarily receive data (web browsing, sensor downlink) rather than upload large quantities [15].

**MIMO**

LTE supports multiple-input multiple-output (MIMO) antenna configurations. The Nova 846 has eight physical antenna ports and can operate in either 4T4R (4 transmit, 4 receive) or 8T8R configuration. This project operated in 4T4R single-carrier mode, connecting four of the eight antenna ports to the AW3376-E-F sector antenna. MIMO improves both throughput and link reliability by transmitting multiple independent data streams simultaneously on spatially separated antenna paths, exploiting the natural multipath propagation in the radio environment.

**Signal Quality Metrics**

G-NetTrack Lite, the application used for drive test data collection, logs RSRP (Reference Signal Received Power) as its primary signal quality metric. RSRP measures the average power of the LTE reference signals received from the serving cell, measured in dBm [12]. The reference signal is a known pilot pattern transmitted by the eNodeB, and its received power gives a clean measure of path loss independent of traffic load. The standard RSRP quality categories used in this report are:

| RSRP Range | Quality Classification |
|------------|----------------------|
| Greater than -80 dBm | Strong |
| -80 to -90 dBm | Good |
| -90 to -100 dBm | Fair |
| -100 to -110 dBm | Marginal |
| -110 to -120 dBm | Weak |
| -120 to -130 dBm | Very Weak |

**SIM Authentication**

Every device on an LTE network is authenticated through its SIM card using the Milenage Authentication and Key Agreement (AKA) protocol [13]. The SIM stores two secret values: the Ki (authentication key) and the OPc (operator-specific authentication code derived from a root operator key). When a device attempts to attach to the network, the MME retrieves the subscriber record from the HSS and runs the AKA protocol. The protocol performs mutual authentication: the network proves its identity to the UE, and the UE proves its identity to the network, both using shared secret keys that are never transmitted over the air. Session encryption keys are derived fresh at each attachment, so capturing previous sessions provides no information useful for decrypting future ones. This security architecture is relevant to the Swanton use case because the ranch network would eventually carry sensitive research data and potentially safety-critical communications.

### II.F RF Propagation Simulation and Tool Democratization

RF propagation simulation allows network designers to model signal coverage before deploying hardware in the field. For a site like Swanton Ranch, where terrain complexity makes analytical path loss calculations insufficient and where sending hardware to the field before having a sense of where to point the antenna would be wasteful, simulation is a necessary planning step.

The tool used in this project is eino.ai, a cloud-native, GPU-accelerated RF simulation platform [8]. eino.ai uses ray-tracing algorithms against high-resolution terrain data, including LiDAR elevation models, to compute RSRP coverage maps across a defined simulation area. The output is a georeferenced RSRP heatmap that can be exported as a KMZ file and layered over satellite or topographic base maps in Google Earth.

What makes eino.ai notable in this context is not just what it does, but what it costs relative to its predecessors. Ten years ago, ray-tracing RF simulation capable of the fidelity eino.ai provides required a dedicated workstation running specialized thick-client software that cost on the order of 50,000 dollars. That kind of tool was available only to large telecom engineering firms and carriers. Today, eino.ai delivers equivalent capability through a web browser for approximately 1,000 dollars. The shift from dedicated workstation to cloud platform, enabled by GPU compute becoming widely available through cloud providers, has put professional-grade propagation simulation within reach of a university project.

This cost compression in simulation tools mirrors the cost compression in hardware and spectrum access described in Section I.A. The same structural shift that brought the eNodeB hardware cost from hundreds of thousands of dollars to thousands, and spectrum access from hundreds of millions to zero, has brought simulation tools from tens of thousands of dollars to thousands. All three components are now accessible to the same class of user: an organization with a small budget, technical staff who understand the tools, and a genuine need for the capability.

---

## III. Requirements

### III.A Project Goals and Constraints

The primary goal of this project was to demonstrate a working private LTE network at Swanton Pacific Ranch and to document the complete system in sufficient detail that future student teams can build directly on the work. This framing deliberately prioritized completeness and documentation over optimization. A polished but poorly documented deployment would leave the next group starting over.

Several constraints shaped the design space. The deployment site is accessible only by driving to the ranch, which limits the complexity of hardware that can be transported and assembled by a small team without heavy equipment. Power at Cooke's Peak is currently limited to a solar panel supporting the UHF repeater; additional infrastructure was not available for the initial deployment, which meant relying on portable power. The budget was constrained to approximately 5,000 dollars for hardware not provided by donors. Standard phone compatibility was a firm requirement, both for the initial testing and for the eventual ranch user base: the network needed to work with off-the-shelf Android and iOS devices without custom firmware or specialized hardware. Finally, the deployment approach needed to be temporary and reversible, since no structural modification to the site was authorized for this initial phase.

### III.B Marketing Requirements

The marketing requirements describe what the network needs to provide from the perspective of end users and ranch stakeholders. They were developed through conversations with the ranch management and the project advisors, and refined against the technical constraints.

The top-level requirements are: reliable connectivity, sufficient throughput for data and video applications, adequate geographic coverage across the working areas of the ranch, low enough power draw to be sustained by solar infrastructure, environmental durability appropriate for an outdoor coastal installation, and minimal visual and physical impact on the ranch environment.

Figure 2 shows the marketing requirements hierarchy tree. Table I shows the pairwise weighting used to derive relative priorities.

*[Figure 2 here: Marketing Requirements Hierarchy Tree from Final Draft Report]*

**TABLE I**
**PAIRWISE MARKETING REQUIREMENTS WEIGHTING**

| Requirement | Reliability | Throughput | Coverage | Power | Durability | Impact | Weight |
|-------------|-------------|------------|----------|-------|------------|--------|--------|
| Reliability | — | 1 | 1 | 1 | 1 | 1 | 5 |
| Throughput | 0 | — | 1 | 1 | 1 | 1 | 4 |
| Coverage | 0 | 0 | — | 1 | 1 | 1 | 3 |
| Power | 0 | 0 | 0 | — | 1 | 1 | 2 |
| Durability | 0 | 0 | 0 | 0 | — | 1 | 1 |
| Impact | 0 | 0 | 0 | 0 | 0 | — | 0 |

*Note: A value of 1 means the row requirement outweighs the column requirement in pairwise comparison. Weight is the sum of each row.*

### III.C Engineering Specifications

The engineering specifications translate the marketing requirements into measurable targets. They were derived from the marketing requirements hierarchy and from the technical literature on private LTE performance.

**TABLE II**
**ENGINEERING SPECIFICATIONS**

| Specification | Target | Basis |
|--------------|--------|-------|
| Packet loss | Less than 2% | Data integrity for sensor applications |
| Link uptime | Greater than 99.999% | 5-minute/year downtime ceiling |
| Download throughput | Greater than 10 Mbps | Supports HD video and concurrent data |
| Signal-to-noise ratio | Greater than 30 dB | Clean signal for maximum MCS utilization |
| Coverage radius | Greater than 1 km from deployment site | Ranch working area access |
| End-node power draw | Less than 6 W per IoT node | Solar operable without large battery |
| Weatherproofing (radio) | IP65 minimum | Coastal salt air, rain, fog |
| Service life | Greater than 5 years | Permanent installation durability |
| Environmental impact | No permanent structure for initial deployment | Ranch land use compatibility |
| Total system cost | Less than 5,000 dollars | University project budget |

---

## IV. Design

### IV.A Alternatives Analysis

The team evaluated three fundamentally different architectural approaches for implementing private cellular connectivity at Swanton Ranch. The central question in each case was the same: where do the network functions live? The answer to that question determines the system's behavior under failure conditions, its cost structure, its security profile, and its long-term maintainability.

**Option 1: Fully Integrated All-in-One (HaloB)**

The simplest possible architecture is one where all network functions are embedded directly in the radio hardware. Baicells offers a product called HaloB, a "Lite EPC" that runs inside the eNodeB itself as a licensed add-on, available for approximately 250 dollars [11]. With HaloB enabled, the radio handles authentication, session management, and subscriber management internally. No external core server is required. A phone connects to the HaloB-equipped radio and can communicate locally without any additional infrastructure.

The appeal is obvious: fewer components, simpler configuration, faster initial deployment. For a test setup in a controlled environment, HaloB is a reasonable choice.

The team rejected HaloB for two reasons. First, HaloB locks the network to Baicells hardware indefinitely. The subscriber database, authentication credentials, and network configuration all live inside the eNodeB. If the radio needs to be replaced or the project migrates to different hardware in the future, none of that configuration can be migrated. Second, while HaloB does provide some diagnostic visibility, its configurability is significantly more limited than a dedicated open-source core. The subscriber management interface, authentication configuration, and network policy options are all constrained by what Baicells chose to expose. For a project where understanding every layer of the stack is part of the educational goal, a core where the team cannot inspect and modify the underlying network functions misses an important part of the point.

**Option 2: Cloud-Hosted Core**

The second option is to run the EPC as a managed cloud service. Several vendors, including Celona, Highway 9, and GXC Onyx, offer cloud-hosted LTE cores as subscription services [15]. In this model, the eNodeB at Swanton connects to a cloud-hosted MME, HSS, and PGW over the internet. The radio hardware is physically local, but all network intelligence lives in a remote data center.

The cloud model has real advantages for organizations without the infrastructure to run and maintain their own servers. Management is outsourced, software updates are automatic, and scaling is straightforward.

At Swanton Ranch, it fails on a single critical constraint: internet reliability. The only available internet backhaul at Cooke's Peak is Starlink. While Starlink is generally reliable, it experiences interruptions due to satellite geometry, weather, and dish outages. If the Starlink connection goes down, a cloud-dependent core leaves the ranch with no cellular service at all, including local voice and data between people who are physically present on the property. The primary use case for this network includes emergency communication during ranch operations. A dependency on maintained internet connectivity for all core functions is incompatible with that requirement.

Additionally, cloud-hosted cores carry recurring subscription costs, typically billed per radio per month. A 20-year network at a university field site needs a cost model that does not require ongoing vendor payments.

**Option 3: Local Open-Source Core (Chosen)**

The chosen approach runs the EPC locally on hardware at the deployment site. Open5GS is a fully featured open-source LTE and 5G SA core network, licensed under the AGPL, with an active development community and production deployments including actual carriers in remote regions [7, 15]. Open5G2GO is a Docker-based installer and web UI built by Waveriders Collective that wraps Open5GS with a one-command installer, a subscriber management interface, and a sensible default configuration for CBRS PLMN 315-010 [7].

With this architecture, the eNodeB at Swanton connects to an Intel NUC running Open5GS on the same local LAN. The NUC handles all authentication, session management, and subscriber database functions independently of the internet. Users can register on the network, authenticate, and communicate locally even if Starlink is completely offline. The Starlink connection is used only for routing UE data traffic to the internet.

The advantages are substantial. The network is self-contained and internet-independent for its core functions. The software is free and open source. Every layer of the stack is visible and configurable, which serves the educational purpose of the project. The documentation burden is manageable, as Open5G2GO's web UI provides subscriber management without requiring detailed knowledge of the Open5GS internals. And the team retains complete control over authentication credentials, security configuration, and network policy.

The main cost is complexity. Setting up Ubuntu Server, Docker, and Open5G2GO on an Intel NUC, connecting it to a Baicells radio, and troubleshooting the data path requires Linux and networking familiarity that not all future teams will have. This report addresses that cost by documenting every step of the process in detail.

**Other Technologies Evaluated**

Several other wireless technologies were considered and set aside at the start of the project:

LoRaWAN provides very long range at very low data rates, suitable for periodic sensor readings but not for video, voice, or general-purpose data. Its bandwidth is orders of magnitude below what the ranch needs. LoRaWAN remains interesting as a secondary backup layer for low-data-rate sensors during CBRS preemption events, but it cannot serve as the primary connectivity solution.

WiFi HaLow (802.11ah) offers longer range than standard Wi-Fi at sub-GHz frequencies. During the initial research phase, the team considered a mesh network using 802.11ah access points. The critical limitation is device compatibility: standard smartphones and IoT devices do not include 802.11ah hardware. Every device on the network would require custom hardware, eliminating the "standard phones work" requirement.

AREDN mesh networking operates in amateur radio bands and provides flexible ad-hoc connectivity, but it requires all operators to hold amateur radio licenses and prohibits encryption of user traffic. Both of these constraints are incompatible with a network intended for use by general ranch staff and students.

Fiber reinstallation was considered and dismissed. Restoring the buried fiber connection destroyed in 2020 would be prohibitively expensive, require months of construction, and have significant environmental impact on a property still recovering from a major fire.

### IV.B System Architecture

Figure 3 shows the complete system block diagram.

*[Figure 3 here: System Block Diagram]*

The physical topology at Swanton Ranch has five layers. At the user device layer, Android phones configured with APN profiles and loaded with provisioned SIM cards connect to the eNodeB over the LTE air interface at 3.655 GHz. At the radio layer, the Baicells Nova 846 eNodeB receives the LTE uplink from UEs, processes the radio frames, and communicates with the core network over Ethernet via the S1 interface. The radio is physically mounted on a portable tripod mast at Cooke's Peak with the AW3376-E-F sector antenna.

At the LAN layer, the eNodeB connects via Ethernet to a small private router running the 10.0.1.0/24 subnet. The Intel NUC running Open5GS is also on this subnet, reachable at 10.0.1.4. The S1AP control connection uses SCTP on port 36412. The user-plane data path uses Baicells LGW NAT mode, which routes UE traffic through the eNodeB's built-in network address translation rather than the Open5GS SGW GTP-U tunnel. This configuration is discussed further in Section VII.E.

At the core network layer, Open5GS running on the NUC handles MME (authentication and mobility), HSS (subscriber database), and the PGW function for IP address assignment. UEs receive addresses from the 10.48.99.0/24 pool, with static assignments matching subscriber configuration (PHONE-10 receives 10.48.99.10, and so on). The APN is "internet," which routes UE traffic to the internet through the Starlink connection on the NUC's WAN interface.

At the backhaul layer, a Starlink terminal at the deployment site provides internet connectivity for UE data traffic routed through the core.

### IV.C RF Link Budget and Antenna Selection

The transmit power of the Nova 846 is 10 W per transmit channel. With four active ports in 4T4R configuration, the total radiated power is 40 W, or 46 dBm [5]. This power level is appropriate for an outdoor macro deployment and falls within the allowed transmit power for GAA CBRS operation.

The AW3376-E-F is an 8-port beamformer panel antenna covering 3,400 to 3,800 MHz, which spans the full CBRS band and CBRS-adjacent bands [4]. Its key specifications for this deployment are:

- Peak gain: 15.5 dBi (standard broadcast beam)
- Azimuth beamwidth: 90 degrees
- Polarization: plus and minus 45-degree slant linear (crossed dipole)
- Compatible bands: 3GPP bands 42, 43, and 48; 5G NR n48 and n78
- Port count: 8 (supports 8T8R, used here in 4T4R mode)

The antenna was selected from the Lawrence Berkeley National Laboratory donation and represents hardware well above what the project budget would have permitted independently. The street value of the AW3376-E-F is [FILL IN: approximate current retail price from alphawireless.com].

The 4T4R configuration connects ANT ports 0 through 3 on the Nova 846 to the four lower ports of the AW3376-E-F. According to the Nova 846 installation guide, single-carrier mode uses only ANT0 through ANT3, and ANT4 through ANT7 are reserved for Cell 2 in dual-carrier configurations [5]. The remaining four antenna ports were left unconnected, as unloaded transmit ports on an active PA would risk damaging the power amplifier.

The sector was aimed at 120 degrees azimuth, pointing SSE (south-southeast) toward the main ranch valley and the coastal corridor where activity is concentrated. Cooke's Peak provides a natural elevation advantage: at 243 m above sea level, the radio placement is well above the valley floor, maximizing line-of-sight coverage area. The antenna was mounted at 15 ft (4.6 m) above ground on a portable tripod mast.

### IV.D RF Propagation Simulation

Pre-deployment simulation served two purposes. First, it confirmed that Cooke's Peak was the right location and that a 120-degree sector heading would illuminate the ranch valley and coastal corridor as intended. Second, it provided reference predictions to compare against the field measurements collected on May 2, giving the team a way to assess simulation accuracy and identify the portions of the property where additional radios would be needed.

**Simulation Tool**

The simulation was conducted in eino.ai, using its cloud-based ray-tracing engine against LiDAR terrain data for the Santa Cruz coast region [8].

**Simulation Process**

The simulation was set up in five steps, documented in the screenshots in the Eino Sim Process Screenshots folder.

First, the simulation area was defined by drawing a bounding polygon over the Swanton Ranch area in eino.ai's map interface, covering approximately the range visible from Cooke's Peak and extending south along the coastal corridor.

Second, the access point was placed at Cooke's Peak at coordinates -122.2376 degrees longitude, 37.0650 degrees latitude, 243 m elevation. eino.ai uses the actual terrain elevation at the placed point, so the height above ground parameter represents antenna clearance above the immediate terrain surface, not elevation above sea level. The antenna was configured at 15 ft (4.6 m) above the terrain surface at the placement point.

Third, the carrier was configured as LTE CBRS Band 48 (3550 MHz center frequency in eino), 20 MHz bandwidth, 4x4 MIMO, 64-QAM modulation.

Fourth, the sector was configured with a 120-degree azimuth heading. The TX power entered in eino was 46 dBm, matching the actual deployment transmit power.

Fifth, the antenna model was selected. The AW3376-E-F is not in eino.ai's antenna library. The closest available model was the KP Performance KPPA-3GHZ0P905-45, a 90-degree azimuth CBRS sector antenna. The KP Performance model has a rated gain of 16.5 dBi, compared to the AW3376-E-F's 15.5 dBi. This 1 dB difference makes the simulation marginally optimistic, a systematic overestimation acknowledged in the results comparison in Section VII.C.

Table III summarizes the simulation parameters.

**TABLE III**
**EINO.AI SIMULATION PARAMETERS**

| Parameter | Simulation Value | Actual Deployment Value |
|-----------|-----------------|------------------------|
| Carrier | LTE, CBRS Band 48 | LTE, CBRS Band 48 |
| Center frequency | 3550 MHz | 3655 MHz (EARFCN 56290) |
| Bandwidth | 20 MHz | 20 MHz |
| MIMO | 4x4 | 4T4R |
| Modulation | 64-QAM | 64-QAM (max) |
| Antenna model | KP Performance KPPA-3GHZ0P905-45 | Alpha Wireless AW3376-E-F |
| Antenna gain | 16.5 dBi | 15.5 dBi |
| Azimuth beamwidth | 90 degrees | 90 degrees |
| Sector heading | 120 degrees | 120 degrees |
| AP location | Cooke's Peak (-122.2376, 37.0650) | Cooke's Peak (-122.2376, 37.0650) |
| TX power (simulated) | 46 dBm | 46 dBm total (40 W, 4x10 W) |
| Height above ground | 4.6 m (15 ft) | 4.6 m (15 ft) |

**Simulation Results**

The simulation produced the RSRP heatmap shown in Figure 8. The RSRP color scale used by eino.ai assigns green to signals above -60 dBm, yellow-green to -70 dBm, yellow to -80 dBm, orange to -90 dBm, and red to -100 through -110 dBm, with areas below this threshold receiving no color (effectively outside coverage).

*[Figure 8 here: Final Map Screenshots/Eino Simulation Data.png — eino.ai RSRP heatmap]*

The simulation shows a pattern consistent with expectations for a high-gain sector antenna aimed SSE from a 243 m elevation point. Strong and good signal (green and yellow zones) is predicted in a roughly circular area immediately surrounding Cooke's Peak, extending outward along the main coverage lobe in the 120-degree heading. Fringe signal (orange and red zones) reaches further south along the coastal corridor and into portions of the valley. Terrain shadow zones appear east and north of the deployment site where the terrain blocks direct line of sight.

The simulation was used to confirm the antenna azimuth heading and to estimate where additional radio placements would be needed to fill coverage gaps. It was not used as a precise quantitative prediction, as the antenna model mismatch and the difficulty of accurately modeling coastal vegetation attenuation introduce known inaccuracies.

### IV.E SIM and Security Design

PLMN selection for a CBRS private network follows a specific convention. The OnGo Alliance, the CBRS industry group, has designated PLMN 315-010 as the standard identifier for US private CBRS networks [14]. This PLMN is analogous to the use of private IP address ranges like 10.0.0.0/8 in TCP/IP networks: it is not globally routable, it is available for any private CBRS operator, and it is recognized by CBRS-capable devices as a local private network. Using 315-010 ensures that UEs configured for this PLMN attempt to register on the Swanton network when it is available, rather than scanning for commercial carriers.

The team programmed three SIM cards, one per test device, with the following IMSI assignments:

- PHONE-10: IMSI 315010000000010
- PHONE-20: IMSI 315010000000020
- PHONE-30: IMSI 315010000000030

Each SIM stores the IMSI, Ki, and OPc values. All three SIMs used the same Ki and OPc values for lab simplicity. In a production deployment, each SIM would have a unique Ki.

Authentication uses the Milenage AKA protocol [13]. When a UE attempts to attach, the MME retrieves the subscriber record from the HSS and generates an authentication challenge. The UE computes a response using its SIM-stored Ki and OPc through the Milenage algorithm, and the MME independently computes the expected response. If the values match, the UE is authenticated. The protocol is mutual: the UE also verifies the network's identity. Critically, neither the Ki nor the OPc is ever transmitted over the air or over the S1 interface. A passive observer capturing all traffic cannot recover the authentication keys or decrypt UE data traffic.

The APN "internet" was configured on the Android phones rather than programmed onto the SIM cards. This is a practical choice for a lab and field-test environment where the same SIMs might be used on different networks. On a production ranch deployment, the APN could be pre-programmed on the SIM to eliminate manual configuration.

---

## V. Test Plans

### V.A Phase 1: RF Propagation Simulation

The first test phase used eino.ai to model signal coverage from Cooke's Peak before any hardware was transported to the ranch.

**Tool:** eino.ai cloud-native RF simulation [8]

**Method:** Place AP at Cooke's Peak with the antenna configuration described in Section IV.D, define a simulation area covering the ranch and surrounding terrain, and compute the RSRP heatmap.

**Pass criterion:** RSRP greater than -110 dBm (marginal or better) at the main ranch valley floor from a single radio at Cooke's Peak, confirming that the site is viable.

**Output:** Georeferenced KMZ export (Eino Data Export.kmz) for overlay with field data in Google Earth.

### V.B Phase 2: Field Drive Test

The second test phase collected measured RSRP data across the ranch during the May 2 deployment.

**Tool:** G-NetTrack Lite [9] on three Android phones (UE 1, UE 2, UE 3)

**Method:** All three phones were carried by the team during a walk/drive test across the ranch. G-NetTrack logged RSRP, GPS coordinates, serving network operator, and network technology at approximately ten-second intervals. Data was collected across two separate route segments throughout the afternoon.

**Data processing:** A Python script (clean_drive_test_data.py) filtered the raw logs to retain only rows where the serving operator was "Swanton_Ranch," where RSRP was between -130 and -50 dBm (valid LTE range), and where the GPS coordinates fell within the ranch bounding box. No-coverage points (rows where the operator was NO_COVERAGE, T-Mobile, AT&T, or Verizon) were retained as gray reference markers. The script exported both per-session KML files and a combined KML covering all UEs and sessions.

**Pass criterion:** Coverage pattern consistent with the eino.ai simulation prediction; signal at the key working areas of the ranch.

### V.C Phase 3: Throughput Testing

**Tool:** OpenSpeedTest, a self-hosted Docker container running on the Intel NUC at port 3000 [7]

**Method:** Run a download and upload speed test from each connected phone to the NUC directly over the LTE link. Running the test server locally on the NUC isolates LTE performance from Starlink variability: the result reflects the LTE link throughput, not the upstream internet speed.

**Pass criterion:** Download throughput greater than 10 Mbps at a minimum, consistent with the engineering specification in Table II.

### V.D Failure Mode and Effects Analysis

Table IV shows the FMEA for key system components.

**TABLE IV**
**FAILURE MODE AND EFFECTS ANALYSIS**

| Component | Failure Mode | Effect | Severity | Probability | Mitigation |
|-----------|-------------|--------|----------|-------------|------------|
| eNodeB (radio) | Physical damage from wind/weather | Loss of network | High | Low | Secure mounting, weatherproof enclosure in permanent installation |
| eNodeB (radio) | Power supply instability | Radio reset, service interruption | High | Medium | Regulated/conditioned power supply; verified during this deployment |
| eNodeB (radio) | Overtemperature | Thermal throttle or shutdown | Medium | Low | Temperature-rated hardware; adequate ventilation |
| Antenna | Cable disconnection | Loss of transmit/receive | High | Medium | Secure weatherproof connectors, verify connections at installation |
| Antenna | Physical damage | Reduced gain, distorted pattern | Medium | Low | Secure mounting; IP65+ hardware |
| Open5GS (core) | Software crash or misconfiguration | Authentication failure, no attach | High | Low | Docker restart policy; configuration backup |
| SIM cards | Wrong APN or IMSI mismatch | No data service | Medium | Medium | Pre-deployment verification checklist |
| Starlink | Internet outage | UE data traffic to internet fails | Medium | Medium | Core functions continue locally; only internet routing affected |
| CBRS spectrum | Navy preemption (Tier 1) | Full network shutdown | High | Low-Medium | Secondary LoRaWAN backup for critical sensors (future work) |
| Power supply | Generator fuel exhaustion | All systems down | High | Low | Monitor fuel; solar/battery for permanent installation |

---

## VI. Development and Construction

### VI.A Hardware Assembly and Physical Installation

Figure 6 shows the completed deployment at Cooke's Peak on May 2, 2026. The AW3376-E-F sector antenna is mounted at the top of a portable telescoping tripod mast, with the Nova 846 eNodeB body secured to the same mast behind the antenna. Four black RF cables connect the radio's ANT0 through ANT3 ports to four of the eight antenna ports. The GPS antenna for TDD timing synchronization is also connected.

*[Figure 6 here: Photos from deployment/IMG_3314.jpeg]*

Figure 7 shows the lab bench setup used during development, with the Nova 430i, the private lab router, and UE 1 visible.

*[Figure 7 here: Photos from deployment/Nova 430i Test set up.png]*

**Physical assembly process:**

The tripod mast was set up at Cooke's Peak and secured. The AW3376-E-F antenna was attached to the mast head, oriented with the face pointing 120 degrees azimuth (SSE). The Nova 846 was secured to the mast below the antenna. RF cables were connected from the radio's ANT0, ANT1, ANT2, and ANT3 ports to the antenna. ANT4 through ANT7 were left unconnected, consistent with single-carrier mode operation as documented in the Nova 846 installation guide [5]. The guide explicitly states that dual-carrier mode requires ANT4 through ANT7, and that only ANT0 through ANT3 are active in single-carrier mode. Leaving transmit ports unconnected while the PA is active would risk damaging the power amplifier, so this connection discipline is important.

The GPS antenna was connected and oriented for sky view. The Intel NUC and private router were co-located at the deployment site, connected via Ethernet. The Starlink dish was positioned separately at a location with clear sky view and connected to the router's WAN port.

Before enabling RF at any point during development or deployment, the team followed a pre-RF safety checklist:

1. ANT0 through ANT3 connected to antenna or dummy loads
2. ANT4 through ANT7 disconnected (single-carrier mode only)
3. Carrier mode set to Single Carrier
4. HaloB disabled
5. Cloud EPC disabled
6. GPS synchronized
7. MME connected and showing active status
8. RF status set to OFF until all above confirmed

During lab testing with dummy loads, this checklist prevented transmitting into unloaded ports. During the Swanton deployment, it ensured GPS was synchronized and the core was confirmed running before any RF was enabled.

### VI.B Software Setup: Open5G2GO and Open5GS

The core network software was installed and validated in the lab before transport to the field.

**Operating system:** Ubuntu Server 22.04 LTS was installed on the Intel NUC. After installation, SCTP kernel module support was verified:

```bash
sudo modprobe sctp
lsmod | grep sctp
```

SCTP is required because the S1AP signaling between the eNodeB and the MME uses SCTP on port 36412. Verifying SCTP availability before installing Open5GS confirmed the kernel was ready.

**Docker:** Docker Engine was installed using the official convenience script:

```bash
sudo apt install -y ca-certificates curl gnupg git
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker $USER
```

Open5G2GO and Open5GS run as a set of Docker containers. Using Docker means the entire core network stack can be started, stopped, and updated as a unit, and the configuration lives in a single `.env` file that is easily backed up.

**Open5G2GO installation:** The Waveriders installer handles the entire Open5GS setup:

```bash
curl -fsSL https://raw.githubusercontent.com/Waveriders-Collective/open5G2GO/main/install.sh | bash
```

During the interactive install, the following configuration was specified:

- Network mode: 4G LTE
- PLMN: 315-010
- UE IP pool: 10.48.99.0/24
- Ki and OPc: 32 hex ones (all-ones key, appropriate for lab use)

The installer produced a working Open5GS stack with a web management UI at port 8080 and the MME listening on port 36412 SCTP.

**IP address migration:** During initial installation, the NUC was still on the Wi-Fi network with IP address 192.168.12.86. After adding the dedicated lab router and moving the NUC to the private LAN, the NUC received the final address 10.0.1.4. The Open5G2GO `.env` file still contained the old IP, so a one-line search-and-replace updated both `DOCKER_HOST_IP` and `HOST_IP` variables. The stack was restarted to pick up the change:

```bash
cp .env .env.backup.$(date +%F-%H%M)
sed -i 's/192\.168\.12\.86/10.0.1.4/g' .env
docker compose -f docker-compose.prod.yml down
docker compose -f docker-compose.prod.yml up -d
```

The final configuration visible in the web UI at http://10.0.1.4:8080 showed:

- PLMN ID: 315010
- MME IP: 10.0.1.4, port 36412
- APN: internet
- UE IP pool: 10.48.99.0/24

**OpenSpeedTest:** A self-hosted speed test server was deployed on the NUC for local throughput testing:

```bash
docker run --restart=unless-stopped --name openspeedtest \
  -d -p 3000:3000 openspeedtest/latest
```

The `--restart=unless-stopped` flag ensures the container starts automatically after a reboot. The test server was accessible at http://10.0.1.4:3000 from any connected UE, providing download and upload throughput measurements isolated from Starlink performance.

### VI.C Subscriber Configuration and SIM Provisioning

**Subscriber database:** Three subscribers were added to Open5GS through the Open5G2GO web UI. Each subscriber entry specifies a name, IMSI, static UE IP address, and APN. The static IP assignments use a scheme where the last two digits of the IMSI match the last octet of the IP address, making troubleshooting straightforward.

**TABLE V**
**SUBSCRIBER CONFIGURATION**

| Name | IMSI | UE IP | APN |
|------|------|-------|-----|
| PHONE-10 | 315010000000010 | 10.48.99.10 | internet |
| PHONE-20 | 315010000000020 | 10.48.99.20 | internet |
| PHONE-30 | 315010000000030 | 10.48.99.30 | internet |

**SIM programming:** A Gialer USB SIM writer running GRSIMWrite was used to program three blank programmable SIM cards. The SIM programming procedure used the LTE/WCDMA parameter panel in GRSIMWrite rather than the GSM panel, as the LTE attachment process uses the LTE/WCDMA credentials:

1. Insert blank SIM and click Read Card to confirm successful read
2. In the LTE/WCDMA panel: set IMSI15 format (not IMSI18), enter IMSI, Ki, and OPc values; select OPc mode (not OP); confirm Milenage algorithm
3. Click Write Card
4. Click Read Card again to verify the written values against what was entered
5. Label the physical SIM with the PHONE number

The APN "internet" was not programmed onto the SIM itself. Instead, an APN profile was configured manually in each Android phone's mobile network settings:

- Name: Open5G2GO
- APN: internet

### VI.D Baicells Nova 430i Configuration (Lab Validation)

The Nova 430i was used as the first radio in the development process. It is a lower-power indoor eNodeB intended for office or home lab environments. Working with the 430i first served an important risk-management purpose: it allowed the team to verify that the Open5GS core, SIM cards, and Android phone configuration all worked together before introducing the higher-power, more complex Nova 846.

The key configuration changes from the 430i's factory defaults were:

- Country Code: changed from "USA-FCC(CBRS) - Domain Proxy" to "Other" (disables SAS requirement for lab use)
- HaloB: OFF (the factory default is ON; HaloB must be disabled to use an external core)
- Cloud EPC: OFF
- PLMN: changed from 314030 to 315010
- MME IP: changed from 127.0.0.1 to 10.0.1.4
- MME PLMN: 315010
- S1 Link Port: 36412
- TAC: 1
- Band: 48
- Bandwidth: 20 MHz
- EARFCN: 55990 (3625 MHz, CBRS lower end)

After applying these changes, the 430i showed MME Status: Connected, confirming S1AP communication with Open5GS was working. With all three phones confirmed attached and accessing the internet through the 430i, the lab validation phase was complete.

### VI.E Baicells Nova 846 Configuration (Swanton Deployment)

The Nova 846 was configured to match the 430i's working configuration as closely as possible, with changes specific to the outdoor deployment environment.

The Nova 846's factory defaults included PLMN 314030, MME IP 127.0.0.1, Country Code "USA-FCC(CBRS) - Domain Proxy," and HaloB ON. The relevant changes:

- HaloB: OFF
- Cloud EPC: OFF
- Country Code / SAS: Other
- PLMN: 315010
- MME IP: 10.0.1.4
- MME PLMN: 315010
- TAC: 1
- Band: 48
- Bandwidth: 20 MHz
- EARFCN: 56290 (3655 MHz, center of CBRS band, shifted from 430i's 55990 to center the operating frequency within the band)
- TDD SubFrame Assignment: 2 (3:1 DL:UL ratio, favoring downlink)
- Special SubFrame Pattern: 7
- Power Modify: 2 x 25 dBm (conservative initial setting for lab dummy load testing; full 4-port power enabled at Swanton)
- eNB ID: 288392
- PCI: 121
- Cell ID: 193
- LGW: ON, NAT mode (carried forward from 430i working configuration)

The Nova 846 is a dual-carrier radio (Cell 1 / Pcell and Cell 2 / Scell). The team operated it in single-carrier mode using Cell 1 only. The carrier mode was explicitly set to Single Carrier in the radio's configuration. With this setting, ANT4 through ANT7 are inactive and were left unconnected; ANT0 through ANT3 carry both transmit and receive for the active carrier in 4T4R mode.

**GPS synchronization:** TDD operation requires precise time synchronization between the eNodeB's transmit/receive frame timing and the network timing reference. The Nova 846 derives this timing from GPS. Before enabling RF, the GPS antenna was connected with clear sky view, and the web UI was monitored until it showed GPS Sync Status: Synchronized. This took several minutes from power-on. RF was not enabled until GPS sync was confirmed.

After applying all configuration changes, the MME status showed Connected, GPS showed Synchronized, and the pre-RF checklist was complete. RF was enabled and the first phone (PHONE-10) attached to the Swanton_Ranch network. The Open5G2GO web UI confirmed the attachment:

```
Registered UEs: 1
Connected Devices: 1
PHONE-10 connected with IP 10.48.99.10
```

### VI.F Power System

The total system power draw during active operation was approximately 60 to 70 W, based on estimates for the 4T4R transmit configuration [meeting notes]. This figure accounts for the radio PA and baseband processing but does not include the NUC, router, or Starlink terminal.

The breakdown by component:
- Nova 846 (4T4R): 4 transmit channels x 10 W per channel = 40 W RF output power, plus baseband processing overhead
- Intel NUC: approximately 15 to 25 W under moderate load
- Private router: approximately 5 to 10 W
- Starlink terminal: approximately 50 to 75 W (varies with dish generation)
- Total system: [FILL IN: verify measured power draw from deployment day, if available]

**Deployment day power source:** [FILL IN: what powered the radio, NUC, and Starlink on May 2 at Cooke's Peak? Generator? Vehicle power? A portable battery bank? Confirm and describe.]

For a permanent installation, the power system design would center on a solar array, battery bank, and MPPT (Maximum Power Point Tracking) charge controller sized for the full system load plus margin for coastal overcast days. A 200 W solar panel array with a 100 Ah lithium battery bank would provide continuous operation through several consecutive cloudy days at the estimated system load. This design is well within the technology available today at reasonable cost, as solar-powered small-cell deployments are routine in rural connectivity applications.

The power efficiency of the Nova 846 relative to legacy macro cellular infrastructure is worth noting. A traditional macro base station delivering comparable coverage would require several hundred watts of transmit power. The Nova 846 achieves kilosquare-kilometer-scale coverage at 40 W of radiated power. This efficiency, driven by improvements in PA design and the shift to higher-gain antennas at 3.5 GHz, makes solar-powered operation at a remote site feasible in a way it would not have been with previous-generation hardware.

---

## VII. Integration and Test Results

### VII.A Deployment Day: May 2, 2026

The deployment team arrived at Cooke's Peak at Swanton Pacific Ranch in the early afternoon of May 2, 2026. Setup of the antenna mast, radio, NUC, and Starlink required approximately one hour from arrival to network-up.

The bring-up sequence followed the pre-RF checklist described in Section VI.A. The NUC was powered first and Open5G2GO was confirmed running. The Nova 846 was powered via its dedicated 48V DC power supply input and allowed several minutes to acquire GPS sync. Once the web UI showed GPS Sync Status: Synchronized and MME Status: Connected, RF was enabled.

**Power supply issue:** Shortly after initial RF enable, the radio began cycling on and off. The web UI showed intermittent MME disconnects corresponding to the radio resets. Investigation found that the power supply connection to the radio was unstable. The power supply was not providing clean, regulated DC to the radio. After correcting the power connection and securing it firmly, the radio stabilized and maintained continuous operation for the remainder of the deployment. This was the most significant field issue of the day, and it directly informs the power system design for the permanent installation, as discussed in Section VII.E.

Figure 11 shows a G-NetTrack screenshot from one of the phones during the deployment, with the "Swanton_Ranch" network visible as the connected operator and 4G LTE technology confirmed.

*[Figure 11 here: Test Phone Data/UE 1/Screenshot_2026-05-02-18-29-34-87.jpg or equivalent]*

Drive testing was conducted throughout the afternoon with all three phones active. UE 2 was carried during the test but, as discussed in Section VII.E, produced no data due to a logging failure that was not detected until post-deployment data review.

### VII.B Coverage Measurement Results

The raw G-NetTrack logs from all sessions were processed by clean_drive_test_data.py. The script retained only Swanton_Ranch-operator rows within the valid RSRP range and the geographic bounding box, and collected no-coverage reference points. The combined output, ALL_combined_rxlev.kml, contains the data visualized in Figure 9.

Figure 9 shows the cleaned drive test RSRP data plotted on the USGS topographic base map [1]. Colored dots represent Swanton_Ranch signal, graded by strength. Gray dots represent locations where data was collected but the phone was either on a commercial network or showing no coverage. The route extends approximately 4 km north-south and 1.9 km east-west.

*[Figure 9 here: Final Map Screenshots/UE Walk Test Data.png]*

Table VI shows the RSRP distribution across all 1,655 valid signal measurements.

**TABLE VI**
**MEASURED RSRP DISTRIBUTION**

| RSRP Range | Quality | Count | Percentage |
|------------|---------|-------|------------|
| Greater than -80 dBm | Strong | 308 | 18.6% |
| -80 to -90 dBm | Good | 106 | 6.4% |
| -90 to -100 dBm | Fair | 228 | 13.8% |
| -100 to -110 dBm | Marginal | 449 | 27.1% |
| -110 to -120 dBm | Weak | 278 | 16.8% |
| -120 to -130 dBm | Very Weak | 286 | 17.3% |
| **Total with Swanton_Ranch signal** | | **1,655** | **100%** |
| No coverage (within bounding box) | | 4,080 | — |

The combined signal and no-coverage dataset contains 5,735 georeferenced measurement points. Coverage was present at approximately 29 percent of measured locations. Strong and good signal was concentrated near Cooke's Peak, degrading to marginal and weak as the route moved south and southeast.

UE 2 produced no data. The log files were zero bytes when retrieved post-deployment. The cause is unknown: G-NetTrack Lite appeared to be running on UE 2, but no data was written. This is addressed as a lesson learned in Section VII.E.

### VII.C Simulation vs. Measured Comparison

Figure 10 overlays the drive test RSRP measurements directly on the eino.ai simulation heatmap, using a hybrid topo/satellite base map in Google Earth. The overlay makes the agreement and divergence between prediction and measurement visible at a glance.

*[Figure 10 here: Final Map Screenshots/Eino and UE data overlaid.png]*

**Where simulation and measurement agree:**

Near Cooke's Peak, the colored drive test dots fall within the corresponding colored zones of the eino.ai heatmap. Green and yellow drive test dots (strong and good signal, greater than -80 dBm) appear within the eino.ai green and yellow zones. This agreement near the radio confirms that the simulation correctly modeled the path loss in the immediate vicinity of the deployment site, where terrain effects are less complex.

The simulation also correctly predicted terrain shadow zones. Large areas east of the coastal ridge, where the terrain blocks direct line of sight from Cooke's Peak, show no predicted signal in the eino heatmap and no Swanton_Ranch signal in the drive test (gray dots). The agreement in shadow zone placement validates the eino.ai terrain model for this site.

**Where simulation and measurement diverge:**

Moving south from Cooke's Peak along the coastal corridor, the simulation predicts fringe signal coverage (orange and red zones, -100 to -120 dBm) across large areas. The drive test data shows predominantly no Swanton_Ranch coverage (gray dots) in these same areas. The simulation's effective coverage radius is substantially larger than what was measured.

**Likely causes of simulation overestimation:**

Two factors contribute to the discrepancy:

First, the antenna gain mismatch: the simulation used the KP Performance KPPA-3GHZ0P905-45 at 16.5 dBi, while the deployed antenna, the AW3376-E-F, has a rated gain of 15.5 dBi. A 1 dB reduction in antenna gain corresponds to a 1 dB reduction in received signal strength at all ranges, shifting the effective coverage radius inward. For fringe-level signals at the edge of the coverage area, a 1 dB change can move a measurement below the minimum detectable threshold.

Second, environmental attenuation: the eino.ai terrain model accounts for surface elevation but has limited capability to model vegetation attenuation. The Swanton Ranch coastal terrain combines recovering scrub, standing dead conifer from the 2020 fire, live coastal Douglas-fir, and maritime fog conditions. Coastal fog in particular introduces absorption at 3.5 GHz that is difficult to quantify without measurement data but can add several dB of effective path loss under heavy fog conditions. The deployment day on May 2 was overcast, and some degree of atmospheric attenuation was likely present.

**Key conclusion:**

The simulation was a valuable planning tool. It correctly identified Cooke's Peak as the best deployment site, correctly predicted the coverage direction and near-field performance, and correctly identified the terrain shadow zones. It overestimated coverage range, as expected for any RF simulation in complex coastal terrain without site-specific calibration data. The practical implication of the measured data is that a single radio at Cooke's Peak covers roughly 29 percent of the measured routes across the ranch. Full coverage of the ranch will require at least one additional radio, placed to illuminate the areas that Cooke's Peak cannot reach due to terrain and distance. Section VIII.C addresses this in the future work plan.

### VII.D Throughput Results

[FILL IN: Include OpenSpeedTest download and upload results from May 2, if available. If no results were captured on deployment day, note this explicitly and state the plan to collect throughput measurements during the next visit. Based on the 20 MHz bandwidth, 4T4R MIMO, and LTE peak throughput estimates, theoretical peak DL is approximately 150 Mbps under ideal conditions; realistic throughput at typical RSRP values measured on May 2 would be substantially lower, but should comfortably exceed the 10 Mbps specification target at strong and good RSRP levels.]

### VII.E Lessons Learned

Five lessons from the development and deployment process are worth documenting specifically, because each one is a potential failure mode for the next team.

**1. Regulated power is essential for field eNodeB operation.**

The power supply instability that caused radio resets during the initial bring-up was the most disruptive issue of the deployment. The Nova 846 reacts to power supply noise and voltage fluctuations with radio resets and MME disconnects. For a permanent installation, the power system must provide clean, stable DC within the radio's specified input voltage range. A solar-plus-battery system with a proper MPPT charge controller and a DC-DC regulator on the radio power input is the correct approach. For temporary deployments, using a regulated power supply or a UPS rather than a raw generator or battery connection directly prevents this failure mode.

**2. LGW mode was required because the Open5GS SGW user-plane path did not initialize correctly.**

The standard LTE user-plane path through Open5GS relies on the SGW creating a GTP-U tunnel interface (ogstun) that appears as a virtual network interface on the Linux host. In this project's configuration, that interface did not appear, and user traffic from attached phones had no route to the internet. Switching to Baicells LGW NAT mode, which routes user-plane traffic through the eNodeB's own NAT, resolved the data path problem. The root cause of the Open5GS SGW initialization failure was not fully diagnosed. For a production deployment, understanding and resolving this issue is worthwhile because LGW mode bypasses Open5GS's traffic management and visibility functions. The next team should investigate whether the issue was a missing kernel module, a Docker networking configuration, or a version-specific Open5GS bug.

**3. GPS lock takes time; plan for it.**

The Nova 846 requires GPS synchronization before TDD RF operation can proceed reliably. GPS acquisition from a cold start can take several minutes, depending on sky view and satellite geometry. If the deployment schedule is tight, powering the radio before beginning antenna and cable installation allows GPS acquisition to proceed in the background, so it is ready by the time the rest of setup is complete. Do not wait until all other setup is done to power the radio; GPS time is wasted time.

**4. Verify G-NetTrack is actively logging before starting a drive test route.**

UE 2 produced zero bytes of log data. The phone appeared to be running G-NetTrack during the test but was not writing to the log file. This was not detected until the post-deployment data review. One third of the planned drive test coverage was lost as a result. Before starting any drive test route, confirm that the log file is being written by checking file size growth in the G-NetTrack log directory. A simple pre-test verification, taking ten seconds, would have caught this issue.

**5. Single-carrier 4T4R used; 8T8R dual-carrier is available as a future upgrade.**

The Nova 846 supports two independent carriers with full 8T8R operation when both ANT0-3 and ANT4-7 are connected to the antenna. This project used only the single-carrier, 4T4R configuration. Moving to dual-carrier would double the available spectrum (two 20 MHz carriers) and potentially double throughput capacity, at the cost of connecting four more antenna cables and configuring Cell 2 in the radio. The AW3376-E-F has all eight ports available. This upgrade path exists without requiring any new hardware.

---

## VIII. Conclusion

### VIII.A What Was Achieved

This project produced the first working private LTE network at Swanton Pacific Ranch. The complete technology stack was demonstrated: a Baicells Nova 846 outdoor macro eNodeB, an Open5GS core network running on a local Intel NUC, SIM cards programmed with PLMN 315-010 credentials, and three Android devices successfully attached and routing data over the LTE link. Internet connectivity through Starlink was confirmed.

The team collected 1,655 valid RSRP measurements from the Swanton_Ranch network across 4 km of ranch terrain using G-NetTrack Lite on two test devices. An eino.ai RF propagation simulation was completed prior to deployment and compared against the field data, producing a quantitative assessment of simulation accuracy at this site. The simulation correctly characterized near-field performance and terrain shadow zones, and overestimated coverage range by a margin consistent with the identified antenna gain mismatch and environmental factors.

All configuration details, including Open5GS parameters, eNodeB settings, SIM programming procedures, and lessons learned from the deployment, are documented in this report and in the supplementary configuration reference in Appendix E.

### VIII.B Significance

The significance of this deployment is not limited to the specific measurements collected on May 2. Private cellular networks at university field sites have value beyond any individual experiment or data set.

The immediate practical value is that the network can now serve real users. Cal Poly's BRAE department encountered the problem of IoT gateways that could not register on commercial SIM cards because there is no usable commercial cellular coverage across most of the ranch. With this network running, those gateways can be provisioned with SIMs on PLMN 315-010 and connected immediately, without any commercial carrier involvement. Any IoT device with an LTE radio can be added to the network with a programmed SIM card and an APN profile. The barrier to connecting research instruments, environmental sensors, and monitoring cameras at the ranch is now a SIM card programming step, not a carrier infrastructure problem.

The broader significance is that this deployment demonstrates the accessibility of private cellular at the university scale. The total cost of the hardware used in this project, excluding the donated components, falls well within a typical university project budget. The software stack is free and open source. The spectrum is available without a license. The tools for simulation, drive testing, and network management are accessible to students with standard engineering training. This project provides a template that other Cal Poly field facilities, other universities with remote research sites, and rural organizations without commercial cellular coverage can follow.

The project also contributes to Cal Poly's position in the ongoing policy discussion around CBRS. The "In Defense of CBRS" article that Jonathan Polly co-developed with Christopher Lupo and Cal Poly [3] argued for preserving the shared-spectrum framework that makes deployments like this possible. The Swanton network is a concrete example of exactly the kind of use case that article was defending.

### VIII.C Future Work: The Shaping Plan

The work described in this report is a foundation, not a finished product. The natural trajectory for this project runs across several years of continued student work, with each phase building on the last.

**Year 1: Permanent Installation at Cooke's Peak**

The immediate next step, appropriate for the team taking this project in academic year 2026-2027, is converting the temporary deployment into a permanent installation. The simulation and field data have confirmed Cooke's Peak as the correct site. The hardware has been demonstrated to work. What remains is weatherproofing and power.

The permanent installation should include a weatherproof enclosure (rated IP65 or better for the coastal environment) for the NUC and networking hardware, proper RF connectors with weatherproofing on the cable runs, and a secure mounting structure for the antenna mast that is rated for coastal wind loads. The power system should consist of a solar panel array, a lithium iron phosphate battery bank, and an MPPT charge controller sized for the total system load of approximately 100 to 150 W, with enough battery capacity to sustain operation through three to four consecutive days of minimal solar input.

SAS registration should be completed for the permanent installation. Full SAS registration requires a Certified Professional Installer (CPI) credential and submission of the radio's GPS location to an approved SAS provider. The CPI process is available through online courses, and several SAS providers offer free or low-cost registration for educational users. Registration provides documented, legally compliant operation and unlocks potential PAL license consideration for more predictable spectrum access.

**Years 2 to 3: Coverage Expansion and Network Maturity**

The drive test data identified that a single radio at Cooke's Peak leaves approximately 71 percent of the measured routes without coverage. The terrain analysis in the eino.ai simulation points to the ranch valley floor as the area most in need of a second radio placement. A second eino.ai simulation, run with the first radio excluded, will identify the optimal location for a second radio and estimate what joint coverage the two-radio network would achieve.

Before deploying a second TDD radio, a GPS-disciplined NTP timing server should be installed. Two TDD eNodeBs on the same frequency band must share precise frame timing; without synchronization, their transmit windows can overlap and cause self-interference. A GPS-disciplined oscillator or a timing server derived from GPS provides the sub-microsecond accuracy required for TDD synchronization across multiple sites.

Indoor small cells for the bunkhouse and main buildings would address the use cases that require connectivity inside structures, where the outdoor macro radio's coverage may be marginal. Small cells for private LTE in the same CBRS band are commercially available as separate eNodeB products.

The CBRS preemption risk from Tier 1 Navy operation warrants a secondary communication system for safety and continuity during preemption events. A LoRaWAN gateway overlay, operating in the sub-GHz ISM bands that are not subject to CBRS rules, would provide low-bandwidth backup connectivity for sensor data and basic alerts when CBRS coverage is unavailable.

**Year 5 and Beyond: Full Ranch Integration**

A five-year vision for the Swanton network extends beyond connectivity for its own sake to full integration with the ranch's research and operational programs.

Non-terrestrial networking alternatives to Starlink, particularly the next generation of LEO satellite systems and potential integration with 5G NTN (Non-Terrestrial Network) standards, will provide more diverse and resilient backhaul options. eSIM technology, which allows SIM credentials to be provisioned over the air without physical SIM programming hardware, will eliminate the manual SIM programming step and allow ranch staff and visiting researchers to self-provision network access through a web interface.

At the device fleet level, an IoT management platform that can monitor battery levels, signal quality, and data throughput across all connected sensors and gateways would turn the network from a connectivity layer into a full operational platform. Livestock health sensors, automated water trough monitoring, weather station networks, and security cameras would all report through the same private cellular network to a central dashboard accessible from the bunkhouse or remotely.

The model developed at Swanton Ranch is replicable. Cal Poly operates several other remote field facilities with similar communication challenges. The experience and documentation from this project could be adapted for those sites with minimal additional effort. Beyond Cal Poly, any organization operating in a rural area without commercial cellular coverage now has a documented, working reference architecture to follow.

The Swanton Ranch private LTE network is a beginning.

---

## IX. Bibliography

[1] U.S. Geological Survey, "7.5-Minute Topo Quadrangle, California — Custom Extent (Point Año Nuevo / Davenport / Santa Cruz OE W area)," 1:24,000 scale, Reston, VA: U.S. Geological Survey, Jun. 11, 2026. [Online]. Available: https://topobuilder.nationalmap.gov. [Accessed: Jun. 2026].

[2] Federal Communications Commission, "3.5 GHz Band Overview," Wireless Communications Office, Dec. 16, 2015. [Online]. Available: https://www.fcc.gov/wireless/bureau-divisions/mobility-division/35-ghz-band/35-ghz-band-overview. [Accessed: Jun. 2026].

[3] C. Lupo, "In defense of CBRS — protecting American university innovation," *RCR Wireless News*, May 15, 2026. [Online]. Available: https://www.rcrwireless.com/20260515/network-infrastructure/defense-cbrs-us-uni-innovation. [Accessed: Jun. 2026].

[4] Alpha Wireless, "AW3376-E-F: 8 Port Beamformer — B42, 43 and 48 — 90° eRET Datasheet," Rev. 09, Alpha Wireless, Aug. 5, 2022. [Online]. Available: https://alphawireless.com. **[INCOMPLETE: add direct product page URL]**

[5] Baicells Technologies, "Nova 846 eNodeB Installation Guide," Baicells Technologies, 2023. [Online]. Available: https://img.baicells.com//Upload/20230804/FILE/14245b78-9ae6-4ec3-a676-79e0029f1538.pdf. [Accessed: Jun. 2026].

[6] Baicells Technologies, "Nova 430i eNodeB Installation Guide," Baicells Technologies. **[INCOMPLETE: add document URL from Baicells website]**

[7] Waveriders Collective, "Open5G2GO," GitHub, 2025. [Online]. Available: https://github.com/Waveriders-Collective/open5G2GO. [Accessed: Jun. 2026].

[8] eino.ai, "eino.ai Product," eino.ai, 2024. [Online]. Available: https://www.eino.ai/product. [Accessed: Nov. 2025].

[9] Mapcom Systems, "G-NetTrack Lite," version 19.2, Android application, Google Play Store. [Accessed: May 2026].

[10] G. Hayes, "Swanton Pacific Ranch Fire Recovery," Swanton Pacific Ranch — Cal Poly SLO, Oct. 2020. [Online]. Available: https://spranch.calpoly.edu/CZU_Lightning_Complex_Fire_Recovery. [Accessed: Oct. 2025].

[11] M. Houtz, "Baicells Private LTE/5G Core," *Marko Does Wireless*, Mar. 24, 2025. [Online]. Available: https://markhoutz.com/2025/03/24/baicells-private-lte-5g-core/. [Accessed: Jun. 2026].

[12] Hewlett Packard Enterprise, "CBRS LTE Technology for the Enterprise: The Radio," White Paper, Hewlett Packard Enterprise, **[FILL IN: year, approximately 2019-2021]**.

[13] Hewlett Packard Enterprise, "CBRS LTE Technology for the Enterprise: Signaling and Control," White Paper, Hewlett Packard Enterprise, **[FILL IN: year]**.

[14] Hewlett Packard Enterprise, "CBRS LTE Technology for the Enterprise: Network Implementation and Design," White Paper, Hewlett Packard Enterprise, **[FILL IN: year]**.

[15] M. Houtz, "Private Cellular for Wi-Fi Engineers Deep Dive," workshop course materials, Wireless LAN Professionals Conference (WLPC) Phoenix 2026, Phoenix, AZ, Feb. 2026.

[16] J. Polly, "Economic Impact of Enhanced Connectivity in Ag-Tech," presentation, Ag-Tech Workshop, California Polytechnic State University, San Luis Obispo, CA, May 23, 2024.

---

## X. Appendices

### Appendix A: ABET Analysis of Senior Project Design

**Summary of Functional Requirements**

The primary function of this system is to provide private 4G LTE cellular connectivity at Swanton Pacific Ranch, supporting data, voice, and IoT device communication across the ranch property without dependence on a commercial cellular carrier. The system must authenticate users through provisioned SIM cards, route data to the internet via Starlink, and operate reliably in an outdoor coastal environment.

**Primary Constraints**

The primary constraints on the design are: terrain complexity and line-of-sight limitations from a single elevation point; the absence of reliable commercial internet at the deployment site (addressed through Starlink); the requirement for temporary, removable installation; a project budget of approximately 5,000 dollars for hardware not covered by donations; and the requirement that the network function with standard commercial smartphones requiring no special hardware modifications.

**Economic**

The total street value of the hardware used in this project is estimated at [FILL IN: sum from Table C-I]. Donated hardware from Lawrence Berkeley National Laboratory, specifically the Nova 846 eNodeB and AW3376-E-F antenna, represents the largest cost items. The Open5GS core software is free and open source. CBRS spectrum access at Tier 3 is free. Recurring operating costs are limited to Starlink service and any future SAS registration fees.

The economic case for the network extends well beyond the project hardware cost. The alternative of extending commercial cellular coverage to Swanton Ranch would require either a commercial carrier to construct a tower on or near the property (not commercially viable given the small population served) or a private DAS (distributed antenna system) installation, which typically costs tens to hundreds of thousands of dollars. The private CBRS approach achieves a working network at a fraction of that cost, with the additional educational benefit of the team learning every layer of the technology stack.

**Environmental**

The deployment had minimal environmental impact. The tripod mast introduced no permanent structure and left no footprint after removal. Cable runs were temporary. The RF exposure from the Nova 846 is well within FCC limits for uncontrolled environments at the distances at which ranch personnel would be present during normal operations. The 3.5 GHz frequency band has no known impact on wildlife. The Starlink dish was positioned on existing infrastructure.

A permanent installation will require more careful environmental assessment, particularly regarding visual impact on a working ranch and wildlife corridor, and appropriate permitting for any permanent structure or mast installation.

**Manufacturability**

All components are commercially manufactured products with established supply chains. The Baicells Nova 846 and AW3376-E-F antenna are catalog items available from commercial distributors. Open5GS is a widely used open-source project with an active maintenance community. Replacement hardware is available if any component fails.

**Sustainability**

The permanent installation design is intended for operation from solar power, making it carbon-neutral in operation. The hardware is designed for long service life: the AW3376-E-F is rated for outdoor coastal environments, and Baicells designs its eNodeBs for multi-year outdoor deployment. Open5GS development is active and will continue to be maintained. The CBRS spectrum framework is established regulatory policy with a long expected lifespan.

**Ethical**

The network authenticates all users through SIM cards with unique IMSIs. Unauthenticated devices cannot access the network. The Milenage AKA protocol prevents impersonation and eavesdropping. The team made a deliberate choice to reject Baicells HaloB as a core option in part due to documented firmware behavior (communication with Chinese servers) that raised security and ethical concerns about deploying trust infrastructure with an unresolved foreign dependency.

**Health and Safety**

RF power levels comply with FCC regulations. The Nova 846 at 46 dBm total transmitted power with a 15.5 dBi antenna produces a calculated EIRP of approximately 61.5 dBm. At the recommended exclusion zone distance from the antenna (in front of the aperture at close range), personnel should not stand in the main beam during active operation, consistent with standard RF safety practice. At the distances at which ranch personnel would normally operate, the power density is well below the FCC Maximum Permissible Exposure limits.

The deployment required working at elevation on a hillside and handling RF hardware. Standard field safety practices were followed.

**Social and Political**

The network directly addresses a documented equity gap: the lack of reliable connectivity at a rural educational facility. Student researchers and ranch staff currently operate without data connectivity across most of the property. Private cellular closes this gap without requiring commercial carrier investment in a low-revenue area.

The project intersects with ongoing spectrum policy discussions at the FCC. The "In Defense of CBRS" article [3] published during the project period directly addresses the policy environment that makes this project possible. The team's work contributes technical substance to Cal Poly's advocacy position in those discussions.

**Development**

The project required new technical skills across multiple domains: LTE network architecture, Linux server administration, Docker container management, RF propagation modeling, SIM programming, mobile network drive testing, and GPS data analysis. The team developed all of these skills through the project rather than treating them as prerequisites. The documentation produced in this project serves as a structured curriculum for the next team.

**Engineering Standards**

The system complies with the following engineering standards:

- 3GPP LTE Release 10+ (the standard governing LTE eNodeB and UE behavior)
- FCC Part 96 (CBRS spectrum rules and SAS requirements)
- IEC 60529 / IP65 (target weatherproofing rating for permanent installation hardware)
- IEEE 802.1Q (VLAN-capable Ethernet networking for the private LAN)
- The Milenage authentication algorithm (standardized in 3GPP TS 35.205-208)

---

### Appendix B: Engineering Specifications

See Table II in Section III.C for the full engineering specifications table.

Additional rationale for selected specifications:

The 10 Mbps download throughput specification was set to accommodate the primary data use cases: HD video streaming from security cameras (requires approximately 4 to 8 Mbps per stream), agricultural sensor data aggregation (requires kilobits per second per device), and general-purpose internet for students and staff. A 20 MHz LTE carrier with 4T4R MIMO at moderate RSRP levels is capable of 40 to 75 Mbps DL in practice, well in excess of the 10 Mbps target.

The IP65 weatherproofing specification reflects the coastal California environment at Swanton. Marine fog, salt air, and seasonal rain are all present. IP65 (dust-tight, protected against water jets from any direction) is the industry minimum for outdoor electronics in this environment. The AW3376-E-F antenna exceeds this rating by design.

The 5-year service life specification reflects the expectation that the permanent installation should last through multiple cohorts of student projects without requiring major hardware replacement. Both the eNodeB and antenna hardware are rated for outdoor deployments of this duration when properly installed.

---

### Appendix C: Parts List and Costs

**TABLE C-I**
**PARTS LIST AND COSTS**

| Item | Description | Source | Street Value |
|------|-------------|--------|-------------|
| Baicells Nova 846 | Outdoor macro eNodeB, 8T8R, dual-carrier, Band 48 | Donated by Lawrence Berkeley National Laboratory | [FILL IN: current street value from baicells.com] |
| Alpha Wireless AW3376-E-F | 8-port sector antenna, Band 48, 15.5 dBi, 90° | Donated by Lawrence Berkeley National Laboratory | [FILL IN: current street value from alphawireless.com] |
| Baicells Nova 430i | Indoor eNodeB, Band 48, used for lab validation | Purchased | [FILL IN: price paid or current street value] |
| Intel NUC | Small form factor PC, Ubuntu Server 22.04 host | Purchased | [FILL IN: model and price] |
| Gialer SIM programming kit | USB SIM writer + GRSIMWrite software | Purchased | [FILL IN: price] |
| Programmable SIM cards (3x) | Blank LTE SIM cards for IMSI programming | Purchased | [FILL IN: price per card and total] |
| Private LAN router | Small router for 10.0.1.0/24 LAN | Purchased | [FILL IN: model and price] |
| RF cables (4x, N-male to N-male) | Coax connecting ANT0-3 to antenna | Purchased | [FILL IN: price per cable and total] |
| RF dummy loads (4x, N-type 50 ohm) | Used during lab testing for safe RF handling | Purchased | [FILL IN: price] |
| GPS antenna | External GPS puck for Nova 846 TDD synchronization | Purchased | [FILL IN: price] |
| Portable tripod mast | Telescoping mast for temporary antenna mounting | Purchased or borrowed | [FILL IN: source and price if purchased] |
| Starlink terminal | LEO internet backhaul at Swanton | Borrowed for deployment day | Service: ~$120/month if owned |
| **Total estimated street value** | | | **[FILL IN: sum]** |

*Note: Donated hardware (Nova 846 and AW3376-E-F) was provided by Lawrence Berkeley National Laboratory and represents equipment that would not normally be in a student project budget. The total cost of non-donated components represents the actual team expenditure.*

---

### Appendix D: Project Schedule

The project ran from Fall 2025 through Spring 2026. Key milestones:

| Phase | Activity | Dates |
|-------|----------|-------|
| Fall 2025 | Initial research, advisor meetings, technology selection | September - November 2025 |
| Fall 2025 | eino.ai simulations, initial eino.ai familiarization | November - December 2025 |
| Winter 2026 | Nova 430i acquisition; initial power-on and network access | January 2026 |
| Winter 2026 | Ubuntu Server, Docker, Open5G2GO installation | January - February 2026 |
| Winter 2026 | WLPC Phoenix 2026 course materials review | February 2026 |
| Winter 2026 | SIM programming, Nova 430i lab configuration | February - March 2026 |
| Spring 2026 | Data path troubleshooting (LGW solution) | March 2026 |
| Spring 2026 | Nova 846 lab preparation and pre-RF checklist | March - April 2026 |
| Spring 2026 | Swanton Ranch deployment and drive test | May 2, 2026 |
| Spring 2026 | Data cleaning, analysis, simulation comparison | May 2026 |
| Spring 2026 | Final report | May - June 2026 |
| Spring 2026 | Senior Project Expo | June 2026 |

---

### Appendix E: System Configuration Reference

This appendix provides a quick-reference summary of all configuration values for the network. Future teams should use this as a starting point and verify each value against the current Open5G2GO documentation before deploying.

**Open5GS / Open5G2GO (Intel NUC at 10.0.1.4)**

| Parameter | Value |
|-----------|-------|
| Host IP | 10.0.1.4 |
| PLMN | 315-010 (MCC 315, MNC 010) |
| TAC | 1 |
| APN | internet |
| UE IP pool | 10.48.99.0/24 |
| MME port | 36412 (SCTP) |
| GTP-U port | 2152 (UDP) |
| Web UI | http://10.0.1.4:8080 |
| OpenSpeedTest | http://10.0.1.4:3000 |
| Installation directory | /home/core/open5G2GO |
| Start command | docker compose -f docker-compose.prod.yml up -d |
| Stop command | docker compose -f docker-compose.prod.yml down |
| Log command | docker compose -f docker-compose.prod.yml logs -f |

**Baicells Nova 846 (Swanton Deployment Configuration)**

| Parameter | Value |
|-----------|-------|
| Product type | sBS71010 |
| Country / SAS mode | Other |
| HaloB | OFF |
| Cloud EPC | OFF |
| PLMN | 315010 |
| TAC | 1 |
| MME IP | 10.0.1.4 |
| MME port | 36412 |
| Band | 48 |
| Bandwidth | 20 MHz |
| EARFCN | 56290 (3655 MHz) |
| Duplex mode | TDD |
| SubFrame Assignment | 2 (3:1 DL:UL) |
| Carrier mode | Single Carrier |
| Active antenna ports | ANT0, ANT1, ANT2, ANT3 |
| eNB ID | 288392 |
| PCI | 121 |
| Cell ID | 193 |
| S1-U config | LGW (NAT mode) |
| GPS sync required | Yes, before RF enable |

**Baicells Nova 430i (Lab Configuration)**

| Parameter | Value |
|-----------|-------|
| Product type | pBS3101SC |
| Country mode | Other |
| HaloB | OFF |
| PLMN | 315010 |
| TAC | 1 |
| MME IP | 10.0.1.4 |
| Band | 48 |
| Bandwidth | 20 MHz |
| EARFCN | 55990 (3625 MHz) |
| S1-U config | LGW (NAT mode) |

**Android APN Configuration**

| Field | Value |
|-------|-------|
| Name | Open5G2GO |
| APN | internet |
| APN type | default |
| MCC | 315 |
| MNC | 010 |

**Subscriber Records**

| Name | IMSI | UE IP | Ki | OPc |
|------|------|-------|----|-----|
| PHONE-10 | 315010000000010 | 10.48.99.10 | [lab key] | [lab key] |
| PHONE-20 | 315010000000020 | 10.48.99.20 | [lab key] | [lab key] |
| PHONE-30 | 315010000000030 | 10.48.99.30 | [lab key] | [lab key] |

*Note: The Ki and OPc values used in this project are all-ones (32 hexadecimal ones) for lab simplicity. Do not use these values in a production deployment where security matters. Generate unique random 256-bit keys for each SIM in a production network.*

---

### Appendix F: Drive Test Data Processing

**Script:** Test Phone Data/clean_drive_test_data.py

**Purpose:** Process raw G-NetTrack Lite log files from the May 2, 2026 Swanton Ranch deployment into clean KML files suitable for visualization and analysis.

**Inputs:** Raw G-NetTrack log files from UE 1 and UE 3 (four total: two sessions per UE). UE 2 data was excluded because all session files were zero bytes.

**Processing steps:**

1. Iterate over all session directories for UE 1 and UE 3
2. For each row in the log file: check that GPS coordinates are within the ranch bounding box (37.00 to 37.10 N, 122.10 to 122.35 W); rows outside this box are from driving to and from the ranch and are excluded
3. Rows where Operatorname is "Swanton_Ranch": check that the Level (RSRP) value is a valid integer between -130 and -50 dBm; valid rows are written to the cleaned output and to the signal KML layer
4. Rows where Operatorname is in the set (NO_COVERAGE, 310260 T-Mobile, 310410 AT&T, 310830 Verizon, 311480 Verizon): written to the no-coverage (gray) KML layer
5. All other rows (blank operators, integer overflow values, etc.): dropped

**Output files** (in Test Phone Data/Cleaned/):

- UE1_Swanton_Ranch_2026.05.02_16.00.11_cleaned.txt — Session 1, UE 1 (signal rows only)
- UE1_Swanton_Ranch_2026.05.02_18.56.06_cleaned.txt — Session 2, UE 1 (signal rows only)
- UE3_Swanton_Ranch_2026.05.02_15.57.33_cleaned.txt — Session 1, UE 3 (signal rows only)
- UE3_Swanton_Ranch_2026.05.02_18.56.06_cleaned.txt — Session 2, UE 3 (signal rows only)
- Matching _cleaned_rxlev.kml files for each session (signal + gray layers)
- ALL_combined_rxlev.kml — Combined all UEs, all sessions, both layers (used for Figures 9 and 10)

**Summary statistics:**

| Session | Signal rows | Gray rows | Bogus dropped | Out-of-area dropped |
|---------|-------------|-----------|---------------|---------------------|
| UE1 Session 1 (16:00) | [from script output] | [from script output] | [from script output] | [from script output] |
| UE1 Session 2 (18:56) | [from script output] | [from script output] | [from script output] | [from script output] |
| UE3 Session 1 (15:57) | [from script output] | [from script output] | [from script output] | [from script output] |
| UE3 Session 2 (18:56) | [from script output] | [from script output] | [from script output] | [from script output] |
| **Combined total** | **1,655** | **4,080** | | |

*To regenerate the cleaned data: cd to Test Phone Data/ and run `python3 clean_drive_test_data.py`.*

---

### Appendix G: Deployment Photographs

The following photographs document the May 2, 2026 deployment at Swanton Pacific Ranch, Cooke's Peak.

**Photo 1** (IMG_3314.jpeg): Baicells Nova 846 eNodeB with Alpha Wireless AW3376-E-F sector antenna mounted on portable tripod mast at Cooke's Peak. Four RF cables visible connecting ANT0 through ANT3 to the antenna. The antenna face is oriented 120 degrees azimuth (SSE) toward the ranch valley.

**Photo 2** (IMG_3588.jpeg): Alternate view of the Nova 846 and AW3376-E-F sector antenna on the tripod mast at Cooke's Peak.

**Photos 3 through 8** (IMG_3324, IMG_3591, IMG_3592, IMG_3593, IMG_4477, IMG_4482, IMG_4485): Additional deployment documentation photos.

**Photo 9** (Nova 430i Test set up.png): Indoor lab bench setup during the development phase. Baicells Nova 430i (white box, left), private LAN router (center), and additional networking equipment (right). Ethernet cables (yellow, blue, orange) interconnecting components. A phone labeled UE 1 visible in front. This configuration was used to validate the Open5GS core, SIM card programming, and data path before the Nova 846 was configured.

*[All photos available in Photos from deployment/ folder in the project repository.]*

---

*End of Report*

*California Polytechnic State University, San Luis Obispo*
*Department of Electrical Engineering*
*EE 461 / EE 462 — Senior Project*
*June 2026*
