extends Node

signal updated_peasant_activity(peasant: Peasant, activity: String)
signal updated_peasant_health(peasant: Peasant, max_health: float, current_health: float)
signal updated_peasant_hunger(peasant: Peasant, max_hunger: float, current_hunger: float)
signal updated_peasant_energy(peasant: Peasant, max_energy: float, current_energy: float)
