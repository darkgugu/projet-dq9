extends Node

# Les statistiques de base de ton personnage à la Dragon Quest
var pseudo : String = "Default_Name"
var niveau : int = 1
var exp_actuelle : int = 0

var pv_max : int = 50
var pv_actuels : int = 50

var pm_max : int = 10
var pm_actuels : int = 10

# Statistiques pour les calculs de combat
var force : int = 12
var agilite : int = 8
var resilience : int = 10 # La défense de base dans DQ


signal pv_changes(pv_actuels, pv_max)

func prendre_degats(montant):
	pv_actuels -= montant
	pv_changes.emit(pv_actuels, pv_max) # On prévient tout le monde !
