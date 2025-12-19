# S Icon Master - A tool for applying folder icons in Windows across multiple directories
![Alt Text](https://i.imgur.com/C5Yedba.png)
<br>
In Windows, it is a tedious process to apply icons to folders, manually having to go into each folder's Properties and change the icon, then select an icon file. With this tool, you can simply dump each .ico file into its respective folder, then run the tool and have it do all the work!
<br>
<br>
<br>
Special thanks to:
<p>-My friend Aureal, for giving me the inspiration for this project. (He really needed this one!)

## Prerequisites
-This app was built using .NET 6.0, and so requires .NET Runtime 6.0 or higher to run. ([.NET Download Link](https://dotnet.microsoft.com/en-us/download))
<br>
## Usage
The tool uses a GUI-based app to run. Simply download the archive from our Releases tab, extract it, and run "S Icon Master.exe".
<br>
<br>
<br>
<b>Usage Instructions:</b>

Step 0: Put each icon you want to use in .ico format in the folder which you want to apply it to.<p>
![Alt Text](https://i.imgur.com/ls58rg0.gif)
<br>
<br>
<br>
Step 1: Open the S Icon Master app and click the Select button, then choose the parent directory containing all the folders you want to apply icons to.<p>
![Alt Text](https://i.imgur.com/nBA1Nnl.gif)
<br>
<br>
<br>
Step 2: Click the Search Selected button to search for available icons. NOTE: Folders with no icons inside them will be ignored.<p>
![Alt Text](https://i.imgur.com/zHoXCyy.gif)
<br>
<br>
<br>
Step 3: You will see a list of every folder containing an icon. Simply click Apply Icons to apply each icon to the folder it's in! NOTE: While the operation will complete almost instantly, some of your applied icons may not show up until after Windows refreshes its icon cache. Refreshing, reopening Explorer, and restarting your computer may help for you to see your new icons quicker!<p>
![Alt Text](https://i.imgur.com/FXAdBEb.gif)
<br>
## FAQ
<b>How do I use this app?</b>
<p>-See "Usage" section.
<br>
<br>
<br>
<b>What happens if there are multiple icons in the same folder?</b>
<p>-Whichever icon comes first alphabetically will be applied.
<br>
<br>
<br>
<b>Why does Windows Defender detect the program as a Wacatac threat?</b>
<p>-Windows Defender detects the DLL shipped with the program as a Wacatac threat because it modifies and deletes desktop.ini files in the folders the icons are being applied to. The desktop.ini files generated and overwritten by the program are considered system files for this method to work. This is a false positive caused by Machine Learning/AI algorithms in the antivirus, and regular antivirus won't detect it. Running the file through VirusTotal, only 3 vendors identify it as suspicious and they're all ML/AI-based:

![Alt Text](https://i.imgur.com/rOikujI.png)

If you're still worried, please check the source code yourself before downloading and compile your own Binary from it in Visual Studio. I have removed the DLL from the source so you can download it without any virus warnings, though I can't do the same for the Release because the program requires the DLL to run.
<br>
<br>
<br>
<b>Do you plan on adding more features?</b>
<p>-Maybe, if I feel like it. This was more of a one-and-done little tool that I wrote in a couple of hours, but if there's enough interest I might add more stuff.
<br>
<br>
<br>
<b>Do you plan on supporting this project with bugfixes, etc.?</b>
<p>-Most likely yes, I like my apps to work properly, but if there are any Windows issues involved I probably won't go out of my way to work around them if it's anything too complex (again, unless there's a lot of interest).
<br>
<br>
<br>
<b>Can the developer be contacted for suggestions?</b>
<p>-Yes! You may email me any suggestions if you'd like. I like to stay on top of my inbox but I can't make any guarantee some emails won't slip through the cracks.
<br>
<br>

## License

This project is licensed under the GNU General Public License v2.0 only
(GPL-2.0-only). See the LICENSE file for details.
