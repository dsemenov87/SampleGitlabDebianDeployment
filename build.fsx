#r "paket:
nuget Fake.Core
nuget Fake.IO.FileSystem
nuget Fake.DotNet.Cli
nuget Fake.Core.Target //"
#load "./.fake/build.fsx/intellisense.fsx"

open Fake
open Fake.IO
open Fake.IO.Globbing.Operators
open Fake.DotNet
open Fake.Core

let branch  = Environment.environVar "branch" 

let buildDir = __SOURCE_DIRECTORY__ + @"/out/"

let configuration = DotNet.BuildConfiguration.Release

let runtime = Some "debian-x64"

// Utils
let publish =
  DotNet.publish (fun opts ->
    {opts with
      Configuration = configuration
      Runtime       = runtime
      OutputPath    = Some buildDir
    })

// Targets
Target.create "Clean" (fun _ -> Shell.cleanDirs [buildDir])

Target.create "UnitTest" (fun _ ->
   for path in !! "./test/*.UnitTests/*.csproj" do DotNet.test id path)

Target.create "PublishApp" (fun _ ->
  for path in !! "./src/*.Application/*.сsproj" do publish path)

Target.create "DebPackage" (fun _ -> Trace.trace "Creating deb-package")

Target.create "Default" ignore

// Dependencies
open Fake.Core.TargetOperators
"Clean"
  ==> "UnitTest"
  ==> "PublishApp"
  =?> ("DebPackage", branch = "master")
  ==> "Default"

// start build
Target.runOrDefault "Default"