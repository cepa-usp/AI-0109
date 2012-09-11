package mundovirtual.controller 
{
	import cepa.multiagent.agent.Agent;
	import cepa.multiagent.agent.AgentEvent;
	import flash.events.EventDispatcher;
	import mundovirtual.model.MV;
	import mundovirtual.model.MVAgent;
	import mundovirtual.model.MVEnvironment;
	import mundovirtual.view.EnvironmentView;
	/**
	 * ...
	 * @author Arthur
	 */
	public class EnvironmentController 
	{
		
		private var view:EnvironmentView;
		private var model:MVEnvironment;
		
		
		public function EnvironmentController(model:MVEnvironment, view:EnvironmentView) 
		{
			this.model = model;
			this.view = view;
			model.eventDispatcher.addEventListener(AgentEvent.AGENT_REGISTERED, onAgentRegistered);
			model.eventDispatcher.addEventListener(AgentEvent.AGENT_POSITIONED, onAgentPositioned);
			
			
			
		}
		
		private function onAgentRegistered(e:AgentEvent):void 
		{
			view.createAgent(MVAgent(e.agent));
		}
		
		/**
		 * Called when an agent is positioned in its registered environment
		 * @param	e
		 */
		private function onAgentPositioned(e:AgentEvent):void 
		{
				
				var agent:MVAgent = MVAgent(e.agent);
				view.setAgentPosition(agent, agent.positionX, agent.positionY, !(e.agent.state == Agent.STATE_CREATING));				
		}
			
		
	}

}