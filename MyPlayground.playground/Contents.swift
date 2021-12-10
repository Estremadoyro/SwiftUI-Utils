import SwiftUI

var greeting = "Hello, pssslaygrounf33d3d"
var age = 38
var mrowohome = 8_000_000

var str1 = """
this is \
the end \
owo
"""

var pi = 3.141
var awesome = true

var score = 85
var str_2 = "Your score was \(score)"
// let is a constant prefix wtf
let taylor = "swift"

// let album: String = "Reputation"

let year: Int = 2_021

let night: Bool = true

let price: Int = 5_400

let userComment = "Cart amount is \(score)"

var cristiano = "Cristiano ronaldo"
var messi = "Lionel Messi"

// Arrays
let players = [cristiano, messi]
players[0]
players[1]

// Sets
let countries = Set(["Peru", "Argentina"])
let countries2 = Set(["Belgica", "Uruguay", "Alemania", "Belgica"])

// Touples
let founders = (company: "Apple", founder: "Steve Jobs")
founders.company

// Dictionaries
let eliminatorias: [String: String] = ["Peru": "8pts", "Chile": "7pts"]
eliminatorias["Peru"]
var peru = "Peru currently has \(eliminatorias["Peru", default: "0pts"])"
// Empty dic
var teams = [String: Int]()
var teams_1 = [String: Int]()
teams_1["Peru"] = 0
// Emtpy array
var teams2 = [Int]()
var teams2_1 = [Int]()
// Empty set
var teams3 = Set<String>()

// Enums
enum Result {
  case success
  case failure
  case owo
}

let result1 = Result.owo

// Enum associations
enum Activity {
  case bored
  case running(destination: String)
  case talking(topic: String)
  case singing(volume: Int)
}

var activity1 = Activity.talking(topic: "World war II")
// Enum with values
enum Planeta: Int {
  case mercury = 1
  case venus
  case earth
  case mars
}

let earth = Planeta(rawValue: 3)

// Operations
var value1: Int = 200_000
let value2: Int = 8_899
let operation1 = value1 % value2
value1 += 2

let lec_teams_1: [String] = ["G2", "Fnatic"]
let lec_teams_2: [String] = ["MAD", "Rouge"]
let lec_teams = lec_teams_1 + lec_teams_2

lec_teams_1 == lec_teams_2
value1 != value2

let firstCard: Int = 11
let secondCard: Int = 10
let folded: Bool = false

if firstCard + secondCard == 21, !folded {
  print("winner winner owo")
} else {
  print("better luck in 2323 years")
}

print(firstCard == secondCard ? "Cards are the same" : "Cards are different bruhh!")

switch secondCard {
case 10:
  print("winner")
default:
  print("lostt")
}

let testScore: Int = 85

switch testScore {
// Excludes 50
case 0 ..< 50:
  print("u trash")
  fallthrough
// Includes final value
case 50 ... 85:
  print("passsed")
default:
  print("prefecto")
}

let count = 1 ... 10
for number in count {
  print("number is: \(number)")
}

let albums: [String] = ["peru", "argentina"]

for album in albums {
  print("\(album)")
}

var number: Int = 1
while number <= 2 {
  print(number)
  number += 1
}

var number2: Int = 0
repeat {
  print(number2)
  number2 += 1
} while number2 <= 3

var owo: Int = 3

var countDown: Int = 10

while countDown <= 10 {
  print(countDown)
  if countDown < 4 {
    print("reached for bruhh")
    break
  }
  countDown -= 1
}

var owo2: String = "im mr oow bro"

outerLoop: for i: Int in 1 ... 10 {
  for j: Int in 1 ... 10 {
    let product: Int = i * j
    print("\(i) * \(j) is \(product)")
    if product == 45 {
      print("product reached 45! @j \(j)")
      break outerLoop
    }
  }
  print("j is done")
}

for i in 1 ... 10 {
  if i % 2 == 1 {
    continue
  }
  print(i)
}

var contador3: Int = 5

while true {
  print("owo")
  contador3 += 1
  if contador3 == 8 {
    break
  }
}

func helper() {
  print("helper function")
}

helper()

func square(number: Int) -> Int {
  return number * number
}

print(square(number: 20))

func sayHello(to name: String) -> String {
  return name
}

var userName: String = sayHello(to: "Adolfo")

func setAlarm(_ time: Int) -> String {
  return ("Alarm set @ \(time)")
}

setAlarm(20)

func greet(_ name: String, nicely: Bool = true) -> String {
  if nicely {
    return ("Yes, name is \(name)")
  } else {
    return ("No")
  }
}

greet("leonardo", nicely: false)

func square2(numbers: Int...) {
  for number in numbers {
    print("\(number) squared is \(number * number)")
  }
}

square2(numbers: 20, 30, 23, 500)

enum PasswordError: Error {
  case obvious
}

func checkPassword(_ password: String) throws -> Bool {
  if password == "password" {
    throw PasswordError.obvious
  }
  return true
}

do {
  try checkPassword("leonardo")
  print("good password bruhh")
} catch {
  print("you cant use that password bruh")
}

// Allows paramter values to be updated
func doubleInPlace(number: inout Int) {
  number *= 2
}

var myNumber: Int = 10
doubleInPlace(number: &myNumber)

// Clousure, are like anon funcs?
let driving = {
  print("im driving owo")
}

driving()

let drivingHome = { (place: String) in
  print("I'm driving \(place) in my car")
}

drivingHome("London")

let drivingHomeReturn = { (place: String) -> String in
  "I'm going to \(place)"
}

let message: String = drivingHomeReturn("Madrid")
print(message)

func travel(action: (_: String) -> Void) {
  print("im getting ready to go owo")
  action("wakanda")
  print("im long gonee")
}

travel(action: drivingHome)

func eat(action: () -> Void) {
  print("im choosing what to eat")
  action()
  print("im full o shit")
}

eat {
  print("i like this burger")
}

let elementExecution = {
  (element: String) -> String in
  "element \(element)"
}

func createElement(action: (_: String) -> String) {
  print("test element")
  action("run element")
  print("finish element")
}

createElement(action: elementExecution)

func travel3(action: (String) -> Void) {
  print("im getting raedy to leave")
  action("Arequipa")
  print("i arrived")
}

// this also invokes the function ?
travel3 { (place: String) in
  print("im travelling to \(place)")
}

func travel4(action: (String) -> String) {
  print("im getting readdy to guu ")
  let description: String = action("New York")
  print(description)
  print("im heere owo")
}

travel4 { (place: String) -> String in
  "I'm travelling tot \(place)"
}

func travel5(action: (String) -> String) {
  print("im getting readdy to leave this sthighole")
  // let desc: String = action("Mexico")
  print(action("Mexico"))
  print("I arrived owowoowo")
}

travel5 {
  "I'm travelling to \($0)"
}

// Trailing closure can only be used if the last
// parameter of a function is a closure
func travel6(action: (String, Int) -> String) {
  print("im getting ready to leaveve")
  print(action("London", 20))
  print("im finally heererer")
}

travel6 { place, speed in
  "Im travelling to \(place) @ \(speed)km/h"
}

// clousure return from function
func travel7() -> ((String) -> String) {
  return {
    "I'm going to \($0)"
  }
}

print(travel7()("London"))

// Closure value capturing
// You can't name closure parameters as the
// clousure itself is being specified as a func parameter
func travel8(day: String) -> ((String) -> Void) {
  var counter: Int = 0
  // Brackets specify its a closure return
  // counter gets captured by the clouse, so it will remain alive
  // after the func is done running
  return {
    print("\(counter). I'm going to \($0) on \(day)")
    counter += 1
  }
}

// Calling travel8 gets us back the clousure
let result: ((String) -> Void) = travel8(day: "Monday")
// then we call it multiple times
result("Machu Picchu")
result("Chichen Itza")

// Random # generator, but don't repeat same number in a row
func makeRandomNumberGenerator() -> (() -> Int) {
  var previousNumber: Int = 0
  return {
    var newNumber: Int
    repeat {
      newNumber = Int.random(in: 1 ... 3)
    } while newNumber == previousNumber
    previousNumber = newNumber
    return newNumber
  }
}

var generator: () -> Int = makeRandomNumberGenerator()
print(generator())
// for _ in 1 ... 10 {
//  print(generator())
// }

// Structs
struct Sport {
  // Stored propperty
  var name: String
  var isOlimpicSport: Bool
  // Computed propperty
  // cannot take parameters
  var olimpicStatus: String {
    if isOlimpicSport {
      return "\(name) is an onlimpic sport"
    } else {
      return "\(name) is an onlimpic sport"
    }
  }
}

// memberwise initializer, pass in arguments corresponding to properties
var sport1 = Sport(name: "Tennis", isOlimpicSport: true)
sport1.name = "Soccer"
print("I'm playing \(sport1.name)")
print(sport1.olimpicStatus)

// Property observer
struct Progress {
  var task: String
  var amount: Int {
    didSet {
      print("\(task) is now @ \(amount)")
    }
  }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 20
progress.amount = 30
progress.amount = 40

struct City {
  var population: Int
  func collectTaxes() -> Int {
    return population * 1_000
  }
}

var lima = City(population: 33_000_000)
print(lima.collectTaxes())

// Mutating methods
struct Person {
  var name: String
  mutating func makeAnonymous() -> String {
    name = "Anonymous"
    return name
  }

  func showName() -> String {
    return name
  }
}

var person1 = Person(name: "Juanito")
print(person1.makeAnonymous())

// Strings are structs
let saying: String = "Too easy bruh"
print(saying.count)
print(saying.hasPrefix("Too"))
print(saying.uppercased())
print(saying.sorted())

// Array methods
var toys: [String] = ["Woody"]
print(toys.count)
toys.append("Buzz")
toys.firstIndex(of: "Buzz")
toys.sorted()
toys.remove(at: 0)

// Initializers
// Custom in struct initializers
// this removes memberwize instance init
// Declare User struct and then a User extension with the custom init
// if you don't wanna lose the memberwize init
struct User {
  var username: String
  // Must init all values, can't be called after a method declaration
  // Struct now takes no arguments if init has no parameters
  // Removes instance auto initializer (memberwize init)
  // if a custom init has been created
  init() {
    username = "Anonymous"
    print("Creating new user")
  }
}

var user1 = User()
user1.username = "speedcell"

// Refering to current instance
struct Student {
  var name: String
  init(name: String) {
    print("\(name) is going to school")
    // self.name -> refers to Student's property
    // name      -> refers to the parameter passed in
    self.name = name
  }
}

var student1 = Student(name: "leo")
student1.name = "Juan"
print(student1.name)
var student2 = student1
student2.name = "James"
// Regardless of having a var point to the same obj
// if the copy's value is updated, it wont' be reflected in the original init
// this only work on Classes
// Class -> James
// Struct -> Juan
print(student1.name)

// Lazy properties
struct FamilyTree {
  init() {
    print("Creating family tree")
  }
}

struct FamilyMember {
  var name: String
  lazy var familyTree = FamilyTree()
  init(name: String) {
    self.name = name
  }
}

var familyMember1 = FamilyMember(name: "Leonardo")
// familtTree property (Which happens to create a struct)
// will not be calculated until its actually used
// It gets calculated only when called
print(familyMember1)
// It gets calculated only when called
familyMember1.familyTree

// Static properties
// Share specific properties and method across all instances
// This property can now be called without needing to instance ClassMate
// Enums can also work if no instance is needed at all
struct ClassMate {
  // static property must be initialized
  // but it shouldn't be passed as an init paramter
  static var classSize: Int = 0
  var name: String
  init(name: String) {
    self.name = name
    // static properties must be accessed from the struct itself
    ClassMate.classSize += 1
  }
}

let adolfo = ClassMate(name: "Adolfo")
let miguel = ClassMate(name: "Miguel")
// Calling the property without initialization
print(ClassMate.classSize)

// Access control
// Makes a property only accessible inside the struct
struct Citizen {
  private let ssn: String
  init(ssn: String) {
    self.ssn = ssn
  }

  func identify() -> String {
    return "My SSN is \(ssn)"
  }
}

var peruvianCitizen = Citizen(ssn: "74387753")
print(peruvianCitizen.identify())
// ssn property is private, so it cannot be accessed outside the struct
// print(peruvianCitizen.ssn)

// Classes
// ## Differ in 5 aspects from structs
class Dog {
  var name: String
  var breed: String
  init(name: String, breed: String) {
    self.name = name
    self.breed = breed
  }

  func details() {
    print("His name is \(name) and he is a \(breed)")
  }

  func makeNoise() {
    print("Wof!")
  }
}

let dog1 = Dog(name: "Dexter", breed: "Poodle")
dog1.details()
// ## Class inheritance
class Poodle: Dog {
  init(name: String) {
    // Swift require us to init the parent element
    super.init(name: name, breed: "Poodle")
  }

  // ## Overriding methods
  override func makeNoise() {
    print("Yip!!")
  }
}

var poodle1 = Poodle(name: "Jack")
poodle1.details()
poodle1.makeNoise()

// ## Final classes
// No other class can inherit from it, so no overriding or using its methods
final class Cat {
  var name: String
  var breed: String
  init(name: String, breed: String) {
    self.name = name
    self.breed = breed
  }
}

// Won't work
// class Persa: Cat {}

// ## Copying objects (inits)
class Singer {
  var name: String = "Adam Levine"
}

var singer = Singer()
print(singer.name)
var singerCopy = singer
// Tarjets the same obj. in memory, so it updates its value
// Structs, don't tarjet the same object in memory
singerCopy.name = "Hoodie Allen"
print(singerCopy.name)

// ## Deinitializers
class Traveller {
  var name: String
  init(name: String) {
    self.name = name
    print("\(self.name) is alive!!")
  }

  func greeting() {
    print("Hello, I'm \(name)")
  }

  deinit {
    print("\(self.name) died :(")
  }
}

var traveller1: Traveller? = Traveller(name: "Michael")
// Force stop execution if traveller1 ends up being nil
traveller1!.greeting()
// denit is executed as Traveller is now deallocated
traveller1 = nil

// objects get destroyed at the end of each loop iteration
for index in 1 ... 3 {
  let traveller2 = Traveller(name: "Steve#\(index)")
  traveller2.greeting()
}

// ## Mutability
// Unlike structs, classes can mutate properties in class-methods
// without the mutating tag prefix in a method
class Movie {
  // in order to prevent a property from mutating by a method in a class
  // it has to be decleared as a variable not a constant (let)
  var name: String = "Spiderman II"
  func changeName() -> String {
    name = "Maze Runner"
    return name
  }
}

var movie1 = Movie()
print(movie1.changeName())

struct Film {
  var name: String = "Titanic"
  mutating func changName() -> String {
    name = "Poseidon"
    return name
  }

  func showName() -> String {
    return name
  }
}

var film1 = Film()
film1.name = "Ice Age"
print(film1.showName())

// Protocols
// ## Dictaminate how structs, classes and enums ought to work
// We can't create instances of a protocol, its a description
// not a type by itself
protocol Identifiable {
  var id: String { get set }
}

// Adopting or Conforming a protocol
struct LaptopUser: Identifiable {
  var id: String
}

struct PcUser: Identifiable {
  var id: String
}

// Create a func that accepts any Identifiable object
func displayID(thing: Identifiable) {
  print("My ID is \(thing.id)")
}

let laptop1 = LaptopUser(id: "001")
let pc1 = PcUser(id: "002")
// The func accepts any struct adapted by the protocol
displayID(thing: laptop1)
displayID(thing: pc1)

// Protocol inheritance
protocol Payable {
  func calculateWages() -> Int
}

protocol NeedsTraining {
  func train() -> String
}

protocol HasVacation {
  func takeVacation(days: Int) -> String
}

protocol Employee: Payable, NeedsTraining, HasVacation {}

struct CompanyEmployee: Employee {
  func calculateWages() -> Int {
    return 930
  }

  func train() -> String {
    return "Has finished training"
  }

  func takeVacation(days: Int) -> String {
    return "Employee has \(days) of vacation left"
  }
}

// Extensions
// # Allow to add methods to EXISTING types: classes, structs, and more?
// We can modify types we don't own
// Can be used to split classes into extensions
// Extensions CANNOT have stored properties
extension Int {
  func squared() -> Int {
    return self * self
  }

  var isEven: Bool {
    return self % 2 == 0
  }
}

var num1: Int = 10
print(num1.squared())
print(num1.isEven)

// Protocol extensions
// Provide default implementations
// Extensions that affect a protocol instead of 1 type only
// Collection is the protocol form Arrays, Sets and Dictionaries
let pythons: [String] = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles: Set<String> = Set(["John", "Paul", "George", "Ringo"])
let seleccion: [String: Int] = ["Lapadula": 14, "Cueva": 10]

extension Collection {
  func summarize() {
    print("There are \(count) of us")
    for name in self {
      print(name)
    }
  }
}

pythons.summarize()
beatles.summarize()
seleccion.summarize()

// Trying it out with custom protocols
protocol SchoolStudent {
  var year: Int { get set }
}

protocol SchoolTeacher {
  var salary: Int { get set }
}

protocol SchoolMemberDetails: SchoolStudent, SchoolTeacher {
  var name: String { get set }
  var bloodType: String { get set }
  func showInfo() -> String
}

extension SchoolMemberDetails {
  func showInfo() -> String {
    return "Student \(name) blood's type is \(bloodType)"
  }
}

// # Protocol Oriented Programming (POP)
// showInfo() is a method from the SchoolMemberDetails protocol
// but it doesn't need to be set as property in the struct
// because a Protocol Extension was declared, giving a default implementation
// of the method
struct SchoolMember: SchoolMemberDetails {
  var year: Int
  var salary: Int
  var name: String
  var bloodType: String
  var age: Int
}

// This example works but the protocol inheritance is not well thought
var schoolMember1 = SchoolMember(year: 1, salary: 1_000, name: "Teemo", bloodType: "B+", age: 22)
print(schoolMember1.showInfo())

// Protocol Oriented Programming (POP)
protocol Identifiable2 {
  var id: String { get set }
  func identify()
}

extension Identifiable2 {
  func identify() {
    print("My ID is \(id)")
  }
}

// This struc didn't need to have the identify function, as the extension
// has given its own default implementation
struct User2: Identifiable2 {
  var id: String
}

let user2 = User2(id: "74387753")
user2.identify()

struct Phone {
  var name: String
  var age: Int
  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
}

// Handling missing data
var distance: Int?
distance = 500

// Unwrapping optionals
var poem: String?
if let poem_unwrapped = poem {
  print("\(poem_unwrapped.count) letters")
} else {
  print("Missing poem")
}

// Unwrapping with guard
// The unwrapped optional remains usable after the guard code
func welcome(_ name: String?) {
  // you don't need to declare a if scenario, just the else
  guard let unwrapped = name else {
    print("You didn't provide a name")
    // guard expects you to return the function
    return
  }
  print("Hello, \(unwrapped)")
}

welcome("leonardo")

// Force unwrapping
// Forces an optional value to unwrap without any conditions
// Code crashed if used and there is no value
let str: String = "5"
let num = Int(str)!
// A warning will pop if num is used while optinal
print("Parsed str is \(num)")

// Implicitly unwrapped optionals
// You don't need to unwrap them in order to use them
// No need for if let or guard let
// Code crashed if used and there is no value
let frames: Int! = nil

// Nil coalescing
// Default value if return is nil
func findByUsername(for id: Int) -> String? {
  if id == 1 {
    return "Senku Ishigami"
  } else {
    return nil
  }
}

// Gives a default value
let user20 = findByUsername(for: 20) ?? "Anonymous"
print(user20)

// Optional chaining
// Acessing stuff like a.b.c and b is optional, a ? can be written to enable
// Optional chaining a.b?.c
let spidermans: [String] = ["Tobey", "Andrew", "Tom"]
// .uppercased() will be ignored if spidermans.first is nil and return nil
let upperSpidermans = spidermans.first?.uppercased()
print(upperSpidermans!)

// Optional try
// Changes throwing functions into funcs that return an optional
// If func throws error, nil will be sent as result instead of the thrown error
// otherwise you get return value wrapped as an optinal
if let result = try? checkPassword("password") {
  print("Result was \(result)")
} else {
  print("Duuh errror")
}

// Used if known for sure the func will not fail (throw an error)
// if func throws an error the code will crash

// If passw rd was passed as argument, the func would've thrown an error
// and the code, consequently, crash
try! checkPassword("password2020")

enum ChangePasswordError: Error {
  case notMatch
  case tooEasy
}

func updatePassword(_ currentPassword: String, _ newPassword: String) throws -> Bool {
  if newPassword == "password" {
    throw ChangePasswordError.tooEasy
  } else if currentPassword != newPassword {
    throw ChangePasswordError.notMatch
  }
  return true
}

if let passwordChange = try? updatePassword("leonardo", "password") {
  print(passwordChange)
} else {
  print("Invalid new password or they don't match")
}

let passwordChange2 = try? updatePassword("leonardo", "password")
print(passwordChange2 ?? false)

// Failable initializers
// Initializer that might work or not
struct Politician {
  var id: String
  init?(id: String) {
    if id.count == 9 {
      self.id = id
    } else {
      return nil
    }
  }
}

// If initialization doens't work, it will return nil
// otherwise it will create the obj
var politic1 = Politician(id: "7438775322")
print(politic1?.id ?? "999999999")

class Animal {}

class Fish: Animal {}

class Cow: Animal {
  func makeNoise() {
    print("Muhh!!")
  }
}

let pets: [Animal] = [Fish(), Cow(), Fish(), Cow()]

for pet in pets {
  if let cow = pet as? Cow {
    cow.makeNoise()
  }
}

// ### Review ###
var cars: [String] = ["audi", "porsche", "toyota"]
type(of: cars)

var array1: [String] = []
var dictionary1: [String: Int] = [:]
// var dictionary1: Dictionary<String, Int> = [:]
var set1: Set<String> = Set([])

enum Weather {
  case sunny
  case clear
  case rainy
}

// Optionar return type
// Return the type or nil
func getWeatherStatus(weather: Weather) -> String? {
  if weather == Weather.rainy {
    return nil
  } else {
    return "Good day owo"
  }
}

// Unwrapping
// Can only use guard inside function
if let result = getWeatherStatus(weather: Weather.rainy) {
  print(result)
} else {
  print("Result is nil :( ")
}

// This won't run
// var result2: String = getWeatherStatus(weather: Weather.clear)

// This will
var result2: String? = getWeatherStatus(weather: Weather.clear)

// Pass an optional inside a func that
// # Unrwapping 1
// Checks if optional has a value, and if so, it unwraps it
// in a non-optional value
// # Unrwapping 2
// Uses guard keyword

enum Country {
  case Peru
  case Italy
  case Spain
}

func yearWorldChampion(country: Country) -> Int? {
  if country == Country.Spain { return 2_010 }
  if country == Country.Italy { return 2_006 }
  return nil
}

if let champion = yearWorldChampion(country: Country.Peru) {
  print(champion)
} else {
  print("This country has never won the world cup ")
}

enum Team {
  case G2
  case FNC
  case VIT
  case MAD
}

func getTitles(team: Team) -> Int? {
  switch team {
  case .FNC, .G2: return 7
  case .MAD: return 2
  default: return nil
  }
}

// Runs isEven only if the func return non nil
// let lolTeam = getTitles(team: Team.G2)?.isEven
let lolTeam = getTitles(team: .VIT)
print(lolTeam ?? "Team has no titles")

enum WeatherType {
  case sun
  case cloud
  case rain
  case wind(speed: Int)
  case snow
}

func getHaterStatus(weather: WeatherType) -> String? {
  switch weather {
  case .sun:
    return nil
  case .wind(let speed) where speed < 10:
    return "meh"
  case .cloud, .wind:
    return "dislike"
  case .rain, .snow:
    return "hate"
  }
}

var hate = getHaterStatus(weather: WeatherType.wind(speed: 10))
print(hate!)

struct Human {
  var sex: String
  var age: Int
}

var man = Human(sex: "Male", age: 22)

var manCopy = man
manCopy.sex = "Female"

// manCopy didn't udpate man, they don't point to the same memory space
print(man)
print(manCopy)

// # Classes
// An instance of a class is called an object
// If you copy an object, both object point at the same data by default
// ~~~~ You can also make class available for Objective-C
@objcMembers class Musician {
  var name: String
  var age: Int
  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }

  func sing() {
    print("owowoo singsingsing")
  }
}

class CountryMusician: Musician {
  override func sing() {
    print("cocaine and pussy signignign")
  }
}

// Needs to create a new intializer inside the new class if the children
// MetalMusicial requires an additional property
class MetalMusician: Musician {
  var noiseLevel: Int
  // Now we require 3 parameters
  init(name: String, age: Int, noiseLevel: Int) {
    // Set class' own property
    self.noiseLevel = noiseLevel
    // Now we need to pass common properties to the parent
    super.init(name: name, age: age)
    // Create metal's own method
  }

  override func sing() {
    print("grhrhrhhrh emtal owowo metal sing")
  }

  // If you want to apple OS to call your code, use objc prefix
  @objc func breakGuitar() {
    print("guitar broken sad owo :(")
  }
}

var singer1 = CountryMusician(name: "Brian Johnson", age: 59)
var singer2 = MetalMusician(name: "James", age: 53, noiseLevel: 90)
singer1.sing()
singer2.sing()
singer2.breakGuitar()

// Propery observers
// 2 kind of observers (willSet & didSet)
struct Clothing {
  var clothes: String {
    // Runs when the property is about to change
    willSet {
      updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
    }
    // Runs when the property has fully updated
    didSet {
      updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
    }
  }
}

func updateUI(msg: String) {
  print(msg)
}

var clothe1 = Clothing(clothes: "jeans")
clothe1.clothes = "Joggers"

// Computed properties
struct Teacher {
  var name: String
  var age: Int
  var ageInDogYears: Int {
    get {
      return age * 7
    }
    set(yearsInAnimal) {
      age = age * yearsInAnimal
    }
  }
}

var teacher1 = Teacher(name: "juan", age: 88)
// This calls the getter
teacher1.ageInDogYears
// This calls the setter
teacher1.ageInDogYears = 10
// Age has been modified by the setter property
// and can be reflecter by reading it (get)
teacher1.age

// # Static properties/methods
// These belong only to the Type (Struct, class)
// and NOT the instance
class PanicAtTheDiscoFan {
  // This is a type property, doesn't belong to an instance
  static var favoriteSong = "The death of a bachellor"
  var name: String
  var age: Int
  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
}

let fan1 = PanicAtTheDiscoFan(name: "leonardo", age: 22)
print(PanicAtTheDiscoFan.favoriteSong)

// ## Access control
class Foreigner {
  // Can only be accessed inside the Type
  private var ssn: String
  // Can only be accessed in the same document
  fileprivate var visaType: String
  init(ssn: String, visaType: String) {
    self.ssn = ssn
    self.visaType = visaType
  }
}

// ## Polymorphisim
// An obj can work as as class and a parent class all at the same time
// You can use the override method depending on the subclass in question

class Album {
  var name: String
  init(name: String) {
    self.name = name
  }

  func getPerformance() -> String {
    return ("The album \(name) sold a shit ton")
  }
}

class StudioAlbum: Album {
  var studio: String
  init(name: String, studio: String) {
    self.studio = studio
    super.init(name: name)
  }

  override func getPerformance() -> String {
    return ("The studio album \(name) sold a shit ton")
  }
}

class LiveAlbum: Album {
  var location: String
  init(name: String, location: String) {
    self.location = location
    super.init(name: name)
  }

  override func getPerformance() -> String {
    return ("The live album \(name) sold a shit ton")
  }
}

var studio1 = StudioAlbum(name: "album1", studio: "studio1")
var studio2 = StudioAlbum(name: "album2", studio: "studio2")
var live1 = LiveAlbum(name: "album3", location: "location1")

var allAlbums: [Album] = [studio1, studio2, live1]

// Type casting
for album in allAlbums {
  // Force down casting
  // Tells swift all albums are StudioAlbums
  // ** let studio = album as! StudioAlbum
  // ** studio.studio
  print(album.getPerformance())
  if let studioAlbum = album as? StudioAlbum {
    print(studioAlbum.studio)
  } else if let liveAlbum = album as? LiveAlbum {
    print(liveAlbum.location)
  }
}

// Optional downcasting at the array level
// Will use an empty array if its not the valid type (LiveAlbum)
for album in allAlbums as? [LiveAlbum] ?? [LiveAlbum]() {
  print(album.location)
  // This only print's one album's location, as there is only One LiveAlbum
}

// ## Type casting is useful when you know sth Swift doesn't
let number1 = 5
// This WONT work
// let text = number1 as! String

// Create a new String, its a new value
// not a re interpretation of the same value

let text = String(number1)
// print(text)

// Clousures
// Random # generator, but don't repeat same number in a row
func randomNumberGenerator() -> (() -> Int) {
  // this var gets captured
  var previousNumber: Int = 0
  return {
    var newNumber: Int
    repeat {
      newNumber = Int.random(in: 1 ... 5)
    } while newNumber == previousNumber
    previousNumber = newNumber
    return newNumber
  }
}

// initialize the func
var randomGenerator = randomNumberGenerator()
// call in the closure in the func
print(randomGenerator())

print("#### ----- ####")
// Closures capture values they use
// values declared outside the closure but are used inside
// to ensure they are still alive when closure is executed
class Pokemon: CustomDebugStringConvertible {
  let name: String
  init(name: String) {
    self.name = name
  }

  var debugDescription: String {
    return ("<Pokemon \(name)>")
  }

  // Run instance is dellocated
  // #5
  deinit {
    print("\(self) escaped!")
  }
  // @escaping makes the closure call leave or 'escape' its scope
  // so it can be used outside the scope
  func delay(_ seconds: Int, closure: @escaping () -> Void) {
    let time = DispatchTime.now() + DispatchTimeInterval.seconds(seconds)
    // manages execution of tasks serially or concurrently
    // .main        -> Associated with the main thrad of the current process
    // .asyncAfter  -> Executes code after a delay of time
    DispatchQueue.main.asyncAfter(deadline: time) {
      // #3
      print("🕑")
      closure()
    }
  }

  // ## ## Default Capture Semantics ## ##
  func demo1() {
    let pokemon = Pokemon(name: name)
    // #1
    print("before closure: \(pokemon)")
    // takes a @scaping closure as argument
    delay(1, closure: {
      // #4
      print("Inside closure: \(pokemon)")
    })
    // #2
    print("bye")
  }
  // ## ## Captured variables are evaluated on execution ## ##
  // Captured variables are evaluated at the closure execution time
  // It captures the reference (pointer) to the variable
  func demo2() {
    var pokemon = Pokemon(name: self.name)
    // #1
    // CAPTURED ONLY A REFERENCE TO THE pokemon VARIBLE
    // NOT THE ACTUAL Pikachu POKEMON
    print("before closure: \(pokemon)")
    // #4 delay is executed
    delay(1, closure: {
      // #5 closure is fially executed
      print("inside closure: \(pokemon)")
      // #6 Mewtwo gets dellocated
    })
    // Swift captures values by reference by default
    // This is when Pikachu gets dellocated
    // ### ## # THE CLOSURE CAPTURED THE REFERENCE TO THE pokemon variable
    // #2 -> Pikachu dellocated
    // as no more variables retain its reference
    // Pikachu stopped being STRONGLY referenced by any variable
    // and got dellocated
    pokemon = Pokemon(name: "Mewtwo")
    // #3
    print("after closure \(pokemon)")
    // Finally Mewtwo gets released once the closure was executed
    // and thenr released by GCD (Grand Central Dispatch)
  }
  // SAME CONCEPT APPLIES TO INT OR OTHER NON INSTANCES
  func demo3() {
    var value = 42
    print("before closure: \(value)")
    delay(1, closure: {
      print("inside closure: \(value)")
    })
    value = 1337
    print("after closure \(value)")
  }
  // ## ## You can modify captured values in closures ## ##
  // If the captured value is a VAR, you can modify its value INSIDE the closure
  func demo4() {
    var value = 42
    print("before closure: \(value)")
    delay(1, closure: {
      print("inside closure 1, before change: \(value)")
      value = 1337
      print("inside closure 1, after change: \(value)")
    })
    delay(2, closure: {
      print("inside closure 2: \(value)")
    })
  }
  // ## ## Capturing a variable as a constant copy ## ##
  // If you want to capture the value of a variable at the point of the
  // closure creation, instead of having it evaluate only when the closure executes
  // Instead of a reference to the variable itself
  func demo5() {
    var value = 42
    // #1
    print("before closure: \(value)")
    // Capture list, writtern between square brackets before arguments
    // and return type
    // Value gets captured at the point of closure creation, and NOT
    // a reference to the variable itself to evaluate it later
    delay(1, closure: {[constValue = value] in
      // #3
      print("inside closure: \(constValue)")
    })
    // Value gets updated, but the CLOSURE has already captured the refere as 42
    value = 1337
    // #2
    print("after closure: \(value)")
  }
  func demo6() {
    var pokemon = Pokemon(name: self.name)
    // #1
    print("before closure: \(pokemon)")
    // This creates a copy of the pokemon value to capture
    delay(1, closure: {[pokemonCopy = pokemon] in
      // #3
      // References to Pikachu even though the variable reference has been updated
      // 1 second ago, that due to the captured value copy
      print("inside closure: \(pokemonCopy)")
    })
    pokemon = Pokemon(name: "Mewtwo")
    // #2
    // Mewtwo gets dellocated
    print("after closure: \(pokemon)")
  }
  func demo6_equivalent() {
    var pokemon = Pokemon(name: self.name)
    print("before closure: \(pokemon)")
    let pokemonCopy = pokemon
    delay(1, closure: {
      print("inside closure: \(pokemonCopy)")
    })
    pokemon = Pokemon(name: "Mewtwo")
    print("after closure: \(pokemon)")
  }
  func demo7() {
    // Mew
    var pokemon = Pokemon(name: self.name)
    print("➡️ Initial pokemon is \(pokemon)")
    // Mew gets captured
    delay(1, closure: {[capturedPokemon = pokemon] in
      print("closure 1 - pokemon captured @ creation time: \(capturedPokemon)")
      print("closure 1 - variable evaluated @ execution time: \(pokemon)")
      pokemon = Pokemon(name: "Pikachu")
      // Mew got dellocated
      print("closure 1 - pokemon has now been set to: \(pokemon)")
    })
    pokemon = Pokemon(name: "Mewtwo")
    print("🔄 pokemon changed to: \(pokemon)")
    // Mewtwo gets captured
    delay(2, closure: {[capturedPokemon = pokemon] in
      print("closure 2 - pokemon captured @ creation time: \(capturedPokemon)")
      print("closure 2 - pokemon captured @ execution time: \(pokemon)")
      pokemon = Pokemon(name: "Charizard")
      // Pikachu got dellocated
      print("closure 2 - pokemon has now been set to \(pokemon)")
      // Mewtwo got dellocated
      // Charizard got dellocated
    })
  }
}

// print("#### -- DEMO 1 -- ####")
// #See how Pokemon is still alive in #4, and notice how deinit ran last
// #pokemon instance was strongly captured (default) by the closure @ print()
// #Pokemon is alive as long as the closure is
// var pokemon1 = Pokemon(name: "Mewtwo")
// pokemon1.demo1()

// print("#### -- DEMO 2 -- ####")
var pokemon2 = Pokemon(name: "Pikachu")
// #Reference to Pikachu gets dellocated as it gets updated with Mewtwo
// What closure captures are REFERENCES to variables, not the value itself
// pokemon2.demo2()

//print("#### -- DEMO 3 -- ####")
// SAME APPLIES WITH TYPE VALUE CAPTURES
//pokemon2.demo3()

//print("#### -- DEMO 4 -- ####")
// #Reference to value changes inside the closure, so the value is updated
//pokemon2.demo4()

//print("#### -- DEMO 5 -- ####")
// # Value gets captured at the creation of the closure and not as a reference
// to the value later on
// The closure does not really strongly capture the variable reference
// IN FACT, IT CAPTURES A COPY OF THE VALUE
// pokemon2.demo5()

//print("#### -- DEMO 6 -- ####")
// Has the same behavior as above but with pokemons
// pokemon2.demo6()

//print("#### -- DEMO 6 EQUIVALENT -- ####")
// Same behavior as demo6 but variable doesn't get captured in a Capture List
// instead the reference is saved in a constant
// pokemon2.demo6_equivalent()

print("#### -- DEMO 7 -- ####")
var pokemon7 = Pokemon(name: "Mew")
pokemon7.demo7()
