'''
This uses a network approach to visualize Bixi bicycle rentals in Montreal
'''

import pandas as pd
import matplotlib.pyplot as plt
import networkx as nx
import random


'''
Data was acquired from Kaggle at this link: https://www.kaggle.com/aubertsigouin/biximtl/data

The visualization was created based on examples in Networkx documentation.
http://networkx.github.io

Additional reference materials used:
 - Pandas documentation;
 - Matplotlib documentation. 

'''
# Load data
stations = pd.read_csv("/Users/ty/Downloads/stations_2017.csv", sep = ";")

rides = pd.read_csv("/Users/ty/Downloads/OD_2017.csv", \
                    usecols = ['start_station_code', \
                    'end_station_code'], \
                    dtype = "category")

# Create a dictionary of stations mapping to their names
stations_dict = {}
for i, j in stations['code'].iteritems():
    if j not in stations_dict:
        stations_dict[j] = stations['name'][i]
        
# Create a dictionary of stations mapping to their coordinates
positions = {}        
for i, j in stations['name'].iteritems():
    if j not in positions:
        positions[j] = (stations['longitude'][i], stations['latitude'][i])

# Clean the data.
rides = rides[rides['end_station_code'] != 'Tabletop (RMA)']

# Match station codes to names
new_list = []
for i, j in rides['start_station_code'].iteritems():
    new_list.append(stations_dict[int(j)])
rides['start_name'] = new_list
new_list = []
for i, j in rides['end_station_code'].iteritems():
    new_list.append(stations_dict[int(j)])
rides['end_name'] = new_list

# Create a list of trips (edges) with start and end stations
rides['as_tuple'] = list(zip(rides['start_name'], rides['end_name']))

# Create a graph with stations as nodes and trips as edges
nwk = nx.Graph()
for i in stations['name']:
    nwk.add_node(i, pos = positions[i])
for i in rides['as_tuple']:
    nwk.add_edge(i[0], i[1])
    
# Choose some stations at random to label
random.seed(123)
named_stations = random.sample(list(stations['name']), 15)
label_list = {}    
for node in nwk.nodes():
    if node in named_stations:
        label_list[node] = node

# Put the plot together and add axis labels, etc.
pos=nx.get_node_attributes(nwk,'pos')
nx.draw_networkx(nwk, pos, node_color = 'green', edge_color = 'black', width = 0.001, node_size = 30, with_labels = False)
nx.draw_networkx_labels(nwk, pos, label_list, fontsize = .5)
plt.rcParams["figure.figsize"] = [20,20]
plt.title("Network Representation of Trips by Bixi \n Bicycles to/from Terminals in Montréal, 2017", fontsize = 20)
plt.xlabel("Longitude", fontsize = 20)
plt.ylabel("Latitude", fontsize = 20)
plt.savefig("Plot.png")
plt.show()
