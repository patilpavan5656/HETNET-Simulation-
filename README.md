This project simulates a Heterogeneous Network (HetNet) environment using MATLAB, where a network area with multiple base stations serves a set of randomly distributed users. The simulation models a scenario with a specified number of macro base stations and small cells (such as pico or femto cells) to analyze user connectivity and Signal-to-Interference-plus-Noise Ratio (SINR) for each user. Users are randomly positioned within the simulation area, and their connections to either a macro base station or a small cell are determined by the highest SINR, calculated based on a distance-dependent path loss model following the 3GPP Urban Macro standard. The SINR is derived by computing the received power from each base station while accounting for path loss and noise. After determining each user’s best connection based on SINR, the simulation displays the user associations and visualizes the positions of users and base stations in a plot. This simulation provides insights into user associations and SINR distributions in a HetNet scenario, which is essential for optimizing network planning and resource allocation in cellular systems.