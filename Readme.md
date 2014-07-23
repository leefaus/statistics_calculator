Welcome to StatMachine	{#about}
=====================


StatMachine is a command line based MLB Statistics Engine.  

----------


Directions
---------

**StatMachine** is a Ruby application

> **Requirements:**
>
> - Ruby runtime 1.9 or above
> - RubyGems
> - Bundler

Once you have installed the above requirements, uncompress statmachine.zip.

----------

> cd statmachine

----------

>  bundle install

----------

>  **bin/statmachine.rb --help**
 
 NAME:

    statmachine.rb

  DESCRIPTION:

    A Program for Calculating MLB Statistics

  COMMANDS:
        
    help                 Display global or [command] help documentation         
    miba                 Most Improved Batting Average          
    sp                   Slugging Percentage            
    tcw                  Triple Crown Winner    

  GLOBAL OPTIONS:
        
    -h, --help 
        Display help documentation
        
    -v, --version 
        Display version information
        
    -t, --trace 
        Display backtrace when an error occurs

----------
To find the most improved batting average:

> **bin/statmachine.rb miba --year 2009**

  NAME:

    miba

  SYNOPSIS:

    statmachine miba [options]
        
  OPTIONS:
        
    --year STRING 
        Starting Year : year to next year. ie, 2009 would be from 2009 to 2010

----------
To find the best slugging percentage for a team

> **bin/statmachine.rb sp --year 2009 --team OAK**

  NAME:

    sp

  SYNOPSIS:

    statmachine sp [options]
        
  OPTIONS:
        
    --team STRING 
        The team to calculate for
        
    --year STRING 
        The year to calculate for
 ----------
 To find out if a player won the triple crown
 
 

> **bin/statmachine.rb tcw --year 2010 --league AL**

  NAME:

    tcw

  SYNOPSIS:

    statmachine tcw [options]
        
  OPTIONS:
        
    --league String 
        The league to calculate for: AL or NL
        
    --year String 
        The year to calculate for

