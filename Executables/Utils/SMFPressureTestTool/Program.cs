using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.Diagnostics;
using System.Threading;

namespace CfgSync
{
    class Program
    {
        static int Main(string[] args)
        {

            string[] commandList = {
                                       "1exam.xml",
                                       "1modify.xml",
                                       "2exam.xml",
                                       "2modify.xml",
                                       "3exam.xml",
                                       "3modify.xml",
                                       "4exam.xml",
                                       "4modify.xml",
                                       "5exam.xml",
                                       "5modify.xml",
                                       "6exam.xml",
                                       "6modify.xml",
                                       "7exam.xml",
                                       "7modify.xml",
                                       "8exam.xml",
                                       "8modify.xml",
                                   };
            
            int ret = 0;
            try
            {
                int timeToSleep = 50;
                if (args.Length > 0)
                {
                    timeToSleep = Convert.ToInt32(args[0]);
                }

                int cmdcnt = 0;
                int lastcnt = cmdcnt;
                int datecnt = 0;
                DateTime timeLast = DateTime.Now;
                do
                {
                    if ( datecnt++ == 20)
                    {
                        datecnt = 0;
                        DateTime timeNow = DateTime.Now;
                        TimeSpan timeSpan = timeNow.Subtract( timeLast );

                        Console.WriteLine(cmdcnt - lastcnt + " command sent in " + timeSpan.Seconds + " seconds " + timeSpan.Milliseconds + " miliseconds");

                        lastcnt = cmdcnt;
                        timeLast = timeNow;
                    }

                    Process p = new Process();

                    string arguments = " 127.0.0.1 8603 ..//commandsfile ";

                    //arguments = arguments + commandFile + " " + responseFile + cmdcnt + ".xml" + " replace 4";
                    arguments = arguments + commandList[cmdcnt % commandList.Length] + " Resp" + cmdcnt + commandList[cmdcnt % commandList.Length] + " replace 4";

                    p.StartInfo.FileName = "SmfRequester.exe";
                    p.StartInfo.Arguments = arguments;
                    p.StartInfo.UseShellExecute = false;
                    p.StartInfo.RedirectStandardInput = true;
                    p.StartInfo.RedirectStandardOutput = true;
                    p.StartInfo.RedirectStandardError = true;
                    p.StartInfo.CreateNoWindow = true;
                    Console.WriteLine("Send command " + commandList[cmdcnt % commandList.Length]); 
                    p.Start();
                    Console.WriteLine("Sleep " + timeToSleep + " mil second");
                    Thread.Sleep(timeToSleep);
                    cmdcnt++;
                } while (true);

            }
            catch (Exception e)
            {

            }
            finally
            {

            }

            return ret;
        }
    }
}
