import './assets/the_daily_brief.scss';

import React from 'react';
import ReactDOM from 'react-dom';
import { Router, Route, IndexRoute, browserHistory } from 'react-router';
import { Provider } from 'react-redux';
import { configure } from 'redux-auth';
import { syncHistoryWithStore } from 'react-router-redux';

import App from './containers/app.jsx';
import TopStories from './containers/top_stories.jsx';
import Latest from './containers/latest.jsx';
import Books from './containers/books.jsx';
import SettingsContainer from './containers/settings_container.jsx';
import TopicsContainer from './containers/topics_container.jsx';
import AboutUsContainer from './containers/about_us_container.jsx';

import configureStore from './store/configure_store.jsx';
import { loadTopics } from './actions/topic_actions.jsx';
import { loadSubtopics } from './actions/subtopic_actions.jsx';
import { loadArticles } from './actions/article_actions.jsx';
import { loadPodcasts } from './actions/podcast_actions.jsx';
import { loadBooks } from './actions/book_actions.jsx';

function initialize({ cookies, isServer, currentLocation } = {}) {
  const store = configureStore();
  store.dispatch( loadTopics() );
  store.dispatch( loadSubtopics() );
  store.dispatch( loadArticles() );
  store.dispatch( loadPodcasts() );
  store.dispatch( loadBooks() );

  const history = syncHistoryWithStore(browserHistory, store);

  const url = (process.env.NODE_ENV === 'development' ? 'http://localhost:3000/api/' : '/api/');

  const getSourceComponent = ( source ) => {
    return (
      React.createClass({
        render() {
          return (
            <Latest type='Source' source={source} />
          )
        }
      })
    )
  }

  const getTopicComponent = ( topic ) => {
    return (
      React.createClass({
        render() {
          return (
            <Latest type='Topic' topic={topic} />
          )
        }
      })
    )
  }

  // Create components for all different sources
  const TheAmericanConservative = getSourceComponent('The American Conservative');
  const Buzzfeed = getSourceComponent('Buzzfeed');
  const CodeSwitch = getSourceComponent('Code Switch');
  const Eater = getSourceComponent('Eater');
  const Economist = getSourceComponent('Economist');
  const ESPN = getSourceComponent('ESPN');
  const FarnamStreet = getSourceComponent('Farnam Street');
  const FastCompany = getSourceComponent('Fast Company');
  const TheFiscalTimes = getSourceComponent('The Fiscal Times');
  const FiveThirtyEight = getSourceComponent('FiveThirtyEight');
  const TheGuardian = getSourceComponent('The Guardian');
  const NewYorker = getSourceComponent('New Yorker');
  const NPR = getSourceComponent('NPR');
  const NYTimes = getSourceComponent('NY Times');
  const PlanetMoney = getSourceComponent('Planet Money');
  const TechCrunch = getSourceComponent('TechCrunch');
  const TedTalks = getSourceComponent('Ted Talks');
  const TheTelegraph = getSourceComponent('The Telegraph');
  const TheAtlantic = getSourceComponent('The Atlantic');
  const TheHill = getSourceComponent('The Hill');
  const Vice = getSourceComponent('Vice');
  const Vox = getSourceComponent('Vox');
  const WashingtonPost = getSourceComponent('Washington Post');
  const MIT = getSourceComponent('MIT Technology Review');
  const Reuters = getSourceComponent('Reuters');
  const A16Z = getSourceComponent('a16z');
  const FromScratch = getSourceComponent('From Scratch');
  const OnlyAGame = getSourceComponent('Only A Game');
  const Embedded = getSourceComponent('Embedded');
  const HiddenBrain = getSourceComponent('Hidden Brain');
  const Forbes = getSourceComponent('Forbes');
  const Quartz = getSourceComponent('Quartz');
  const TedIdeas = getSourceComponent('TED Ideas');
  const BillSimmons = getSourceComponent('Bill Simmons');
  const TheRinger = getSourceComponent('The Ringer');
  const Priceonomics = getSourceComponent('Priceonomics');
  const Backchannel = getSourceComponent('Backchannel');
  const Bright = getSourceComponent('Bright');
  const Synapse = getSourceComponent('Synapse');
  const TeachersGuild = getSourceComponent('Teachers Guild');
  const StartsWithABang = getSourceComponent('Starts With A Bang');
  const BullMarket = getSourceComponent('Bull Market');
  const TheFathomCollection = getSourceComponent('The Fathom Collection');
  const WorldEconomicForum = getSourceComponent('World Economic Forum');
  const TheDevelopmentSet = getSourceComponent('The Development Set');
  const Eidolon = getSourceComponent('Eidolon');
  const AfroAsianVisions = getSourceComponent('Afro Asian Visions');
  const Ashoka = getSourceComponent('Ashoka');
  const Politico = getSourceComponent('Politico');
  const BBC = getSourceComponent('BBC');
  const NiskanenCenter = getSourceComponent('Niskanen Center');
  const Reason = getSourceComponent('Reason');
  const CatoInstitute = getSourceComponent('Cato Institute');
  const TheWeeklyStandard = getSourceComponent('The Weekly Standard');
  const TheRead = getSourceComponent('The Read');
  const ChristianScienceMonitor = getSourceComponent('Christian Science Monitor');
  const ArsTechnica = getSourceComponent('Ars Technica');
  const Gamespot = getSourceComponent('Gamespot');
  const IGN = getSourceComponent('IGN');
  const EdScoop = getSourceComponent('EdScoop');

  // Create components for all different topics
  const Politics = getTopicComponent('Politics');
  const Business = getTopicComponent('Business');
  const Tech = getTopicComponent('Tech');
  const Science = getTopicComponent('Science');
  const Sports = getTopicComponent('Sports');
  const Arts = getTopicComponent('Arts');
  const Food = getTopicComponent('Food');
  const Travel = getTopicComponent('Travel');
  const Race = getTopicComponent('Race');
  const Education = getTopicComponent('Education');
  const Gaming = getTopicComponent('Gaming');
  const World = getTopicComponent('World');

  return store.dispatch(configure(
    {apiUrl: url},
    {isServer: false, cookies, currentLocation, clientOnly: true}
  )).then(({ redirectPath, blank } = {}) => {
    ReactDOM.render((
      <Provider store={store}>
        <Router history={history}>
          <Route path="/" component={App}>
            <IndexRoute component={TopStories} />
            <Route path="/latest" component={Latest} />
            <Route path="/books" component={Books} />
            <Route path="/settings" component={SettingsContainer} />
            <Route path="/topics" component={TopicsContainer} />
            <Route path="/about_us" component={AboutUsContainer} />
            <Route path="/the_american_conservative" component={TheAmericanConservative} />
            <Route path="/buzzfeed" component={Buzzfeed} />
            <Route path="/code_switch" component={CodeSwitch} />
            <Route path="/eater" component={Eater} />
            <Route path="/economist" component={Economist} />
            <Route path="/espn" component={ESPN} />
            <Route path="/farnam_street" component={FarnamStreet} />
            <Route path="/fast_company" component={FastCompany} />
            <Route path="/the_fiscal_times" component={TheFiscalTimes} />
            <Route path="/fivethirtyeight" component={FiveThirtyEight} />
            <Route path="/the_guardian" component={TheGuardian} />
            <Route path="/new_yorker" component={NewYorker} />
            <Route path="/npr" component={NPR} />
            <Route path="/ny_times" component={NYTimes} />
            <Route path="/planet_money" component={PlanetMoney} />
            <Route path="/techcrunch" component={TechCrunch} />
            <Route path="/ted_talks" component={TedTalks} />
            <Route path="/the_telegraph" component={TheTelegraph} />
            <Route path="/the_atlantic" component={TheAtlantic} />
            <Route path="/the_hill" component={TheHill} />
            <Route path="/vice" component={Vice} />
            <Route path="/vox" component={Vox} />
            <Route path="/washington_post" component={WashingtonPost} />
            <Route path="/mit_technology_review" component={MIT} />
            <Route path="/reuters" component={Reuters} />
            <Route path="/a16z" component={A16Z} />
            <Route path="/from_scratch" component={FromScratch} />
            <Route path="/only_a_game" component={OnlyAGame} />
            <Route path="/embedded" component={Embedded} />
            <Route path="/hidden_brain" component={HiddenBrain} />
            <Route path="/forbes" component={Forbes} />
            <Route path="/quartz" component={Quartz} />
            <Route path="/ted_ideas" component={TedIdeas} />
            <Route path="/bill_simmons" component={BillSimmons} />
            <Route path="/the_ringer" component={TheRinger} />
            <Route path="/priceonomics" component={Priceonomics} />
            <Route path="/backchannel" component={Backchannel} />
            <Route path="/bright" component={Bright} />
            <Route path="/synapse" component={Synapse} />
            <Route path="/teachers_guild" component={TeachersGuild} />
            <Route path="/starts_with_a_bang" component={StartsWithABang} />
            <Route path="/bull_market" component={BullMarket} />
            <Route path="/the_fathom_collection" component={TheFathomCollection} />
            <Route path="/world_economic_forum" component={WorldEconomicForum} />
            <Route path="/the_development_set" component={TheDevelopmentSet} />
            <Route path="/eidolon" component={Eidolon} />
            <Route path="/afro_asian_visions" component={AfroAsianVisions} />
            <Route path="/ashoka" component={Ashoka} />
            <Route path="/politico" component={Politico} />
            <Route path="/bbc" component={BBC} />
            <Route path="/niskanen_center" component={NiskanenCenter} />
            <Route path="/reason" component={Reason} />
            <Route path="/cato_institute" component={CatoInstitute} />
            <Route path="/the_weekly_standard" component={TheWeeklyStandard} />
            <Route path="/the_read" component={TheRead} />
            <Route path="/christian_science_monitor" component={ChristianScienceMonitor} />
            <Route path="/ars_technica" component={ArsTechnica} />
            <Route path="/gamespot" component={Gamespot} />
            <Route path="/ign" component={IGN} />
            <Route path="/edscoop" component={EdScoop} />
            <Route path="/politics" component={Politics} />
            <Route path="/business" component={Business} />
            <Route path="/tech" component={Tech} />
            <Route path="/science" component={Science} />
            <Route path="/sports" component={Sports} />
            <Route path="/arts" component={Arts} />
            <Route path="/food" component={Food} />
            <Route path="/travel" component={Travel} />
            <Route path="/race" component={Race} />
            <Route path="/education" component={Education} />
            <Route path="/gaming" component={Gaming} />
            <Route path="/world" component={World} />
          </Route>
        </Router>
      </Provider>
      ),
      document.getElementById('site-main')
    )
  });
}

initialize();